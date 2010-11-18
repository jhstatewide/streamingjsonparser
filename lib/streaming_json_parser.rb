#   This program is free software: you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
#
#
# 

# The StreamingJSONParser may be used when an HTTP server
# returns JSON objects in chunks.
# Add the chunks with << and then ask process to see if there are any
# available.
# @author Joshua Harding
class StreamingJSONParser

  def initialize
    @buffer = ""
  end

  # Adds a string to the parser's buffer
  #
  # @param [String] string to be added to the buffer
  def <<(string)
    @buffer << string
  end

  # Access the current's buffer's contents
  #
  # @return [String] the contents of the parser's buffer
  def buffer
    @buffer
  end

  # Examine the buffer and possibly return a list of JSON chunks
  #
  # @return [Array] a list of strings containing complete JSON documents
  def process
    # start of first JSON
    startpos = nil
    # end of last JSON
    endpos = nil
    # current position of JSON cursor
    cursorpos = 0
    # brace nest count
    bracecount = 0
    # character positions of first { and } of repeated JSON docs
    spans = []
    # are we inside "
    in_double_quote = false
    # are we inside '
    in_single_quote = false
    
    @buffer.length.times do |i|
      current_char = @buffer[i,1]
      last_char = @buffer[i-1,1]

      # if the last character is escaped this means
      # we don't have to process anything..
      next if last_char == '\\'

      # okay, now if we are in a quote and then skip if needed
      if in_double_quote
        next if current_char != '"'
      end

      # okay, now if we are in single quote and then skip if needed
      if in_single_quote
        next if current_char != "'"
      end
      
      case current_char
      when '"'
        # flip the bit
        in_double_quote = in_double_quote ? false : true

      when "'"
        in_single_quote = in_single_quote ? false : true

      when '{'
        startpos = i if startpos == nil
        bracecount += 1
        if bracecount == 1
          cursorpos = i
        end

      when '}'
        bracecount -= 1

        # this signifies that we have found a closing brace!
        if bracecount == 0
          spans << [cursorpos, i]
          cursorpos = i
          endpos = i
        end
      end # end of Case

    end
    # take the 'spans' and then turn them into string fragments
    strings = spans.map {|span| @buffer[span[0], span[1]-span[0]+1]}
    # if we found some JSON chop off the beginning of the string...
    if (startpos != nil && endpos != nil)
      @buffer = @buffer[endpos+1 .. @buffer.length+1]
    end
    return strings
  end
end

StreamingJSONParser
====================================

**Homepage**:     [http://github.com/jhstatewide/streamingjsonparser](http://github.com/jhstatewide/streamingjsonparser)
**Git**:          [http://github.com/jhstatewide/streamingjsonparser](http://github.com/jhstatewide/streamingjsonparser)   
**Author**:       Joshua Harding
**Copyright**:    2010
**License**:      GPL
**Latest Version**: 0.1
**Release Date**: November 17th 2010

Synopsis
--------

StreamingJSONParser allows you to receive JSON in chunks from a webserver
and easily extract (hopefully) well formed JSON.

This gem was developed to interface to [Riak](https://wiki.basho.com/display/RIAK/Riak).

Example
-------
<code>
streaming_json_parser = StreamingJSONParser.new
uri = URI.parse("http://example.com/json_stream")
http = Net::HTTP.new(uri.host, uri.port)
\# mmm, chunky HTTP
http.request_get(uri.request_uri) do |res|
    res.read_body do |chunk|
       streaming_json_parser << chunk
       json_documents = streaming_json_parser.process
       if json_documents.length > 0
          do_something_interesting_with(json_documents)
       end
    end
end
</code>

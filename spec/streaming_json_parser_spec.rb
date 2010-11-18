require 'lib/streaming_json_parser'

describe StreamingJSONParser do
  before(:each) do
    @streaming_j_s_o_n_parser = StreamingJSONParser.new
  end

  it "can processes" do
    @sjparser = StreamingJSONParser.new
    @sjparser <<  <<-EOJSON
    {json: rocks}
    EOJSON
    @sjparser.process.first.should == "{json: rocks}"
  end

  it "can nested process" do
    @sjparser = StreamingJSONParser.new
    @sjparser <<  <<-EOJSON
    {json: {really: 'rocks'}}
    EOJSON
    @sjparser.process.first.should == "{json: {really: 'rocks'}}"
  end

  it "can do two!" do
    @sjparser = StreamingJSONParser.new
    @sjparser <<  <<-EOJSON
    {json: {really: 'rocks'}}{here: 'cookies'}
    EOJSON
    @sjparser.process.should == ["{json: {really: 'rocks'}}", "{here: 'cookies'}"]
  end

  it "can handle escaped braces!" do
    @sjparser = StreamingJSONParser.new
    @sjparser <<  <<-EOJSON
    {json: {brace: "\\{"}}{here: 'cookies'}
    EOJSON
    ret_val = @sjparser.process
    ret_val[0].should == '{json: {brace: "\{"}}'
    ret_val[1].should == "{here: 'cookies'}"
  end

  it "can handle a quoted bracket" do
    @sjparser = StreamingJSONParser.new
    @sjparser <<  <<-EOJSON
    {brace: "{"}
    EOJSON
    ret_val = @sjparser.process
    ret_val[0].should == '{brace: "{"}'
  end

  it "can handle a single quoted bracket" do
    @sjparser = StreamingJSONParser.new
    input = <<-EOJSON
    {brace: '{'}{another: 'bracey }'}
    EOJSON
    @sjparser << input.chomp
    ret_val = @sjparser.process
    ret_val[0].should == '{brace: \'{\'}'
    ret_val[1].should == "{another: 'bracey }'}"
    @sjparser.buffer.should == ""
  end

  it "can keep stuff in buffer!" do
    @sjparser = StreamingJSONParser.new
    input = <<-EOJSON
    {json: 'rocks!'}EXTRAJUNK
    EOJSON
    @sjparser << input.chomp
    @sjparser.process
    @sjparser.buffer.should == "EXTRAJUNK"
  end

  it "correctly handles incomplete fragment!" do
    @sjparser = StreamingJSONParser.new
    input = <<-EOJSON
    {json: 'rocks!'}{incom
    EOJSON
    @sjparser << input.chomp
    @sjparser.process
    @sjparser.buffer.should == "{incom"
    @sjparser << "plete: 'yes!'}"
    @sjparser.process.first.should == "{incomplete: 'yes!'}"
    @sjparser.buffer.should == ""
  end


end


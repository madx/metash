require File.join( File.dirname(__FILE__), 'lib', 'metash' )

describe Metash do
  
  describe ".new" do

    it "should start from a blank slate" do
      mh = Metash.new :key => :val
      mh.should_not respond_to(:anything_but_key)
      mh.should     respond_to(:key)
    end

    it "should recurse a hash to make every children hashes a metash" do
      mh = Metash.new :key1 => :val1, :key2 => {:subkey => :val2}
      mh.key1.should eql(:val1)
      mh.key2.subkey.should eql(:val2)
    end

  end

  describe "#inspect" do

    it "should return a nice string" do
      mh = Metash.new :key => :val
      mh.inspect.should eql("{key: :val}")
    end

    it "should return nested strings" do
      mh = Metash.new :key => { :nested => :val }
      mh.inspect.should eql("{key.nested: :val}")
    end

  end

end

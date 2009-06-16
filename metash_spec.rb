require File.join( File.dirname(__FILE__), 'lib', 'metash' )

describe Metash do
  
  it "should respond to base methods and queries" do
    m = Metash.new
    [:__id__, :__send__].each do |meth|
      m.should respond_to(meth)
    end

    [:eql?, :equal?, :frozen?, :instance_of?, :is_a?, :kind_of?, 
     :nil?, :respond_to?, :tainted?, :instance_eval].each do |meth|
      m.should respond_to(meth)
    end

    m.should_not respond_to(:clone)
    m.should_not respond_to(:hash)
    m.should_not respond_to(:anything_in_fact)
  end
  
  describe ".new" do

    it "should recurse a hash to make every children hashes a metash" do
      mh = Metash.new :key1 => :val1, :key2 => {:subkey => :val2}
      mh.key1.should eql(:val1)
      mh.key2.subkey.should eql(:val2)
    end

  end

  describe "#inspect" do
    
    before(:all) do
      @simple  = Metash.new :simple  => "value"
      @nested  = Metash.new :nested  => { :key  => :value }
      @complex = Metash.new :complex => { :key1 => :value1, :key2 => :value2 }
    end

    it "should return a nice string for simple metashes" do
      @simple.inspect.should eql('{simple: "value"}') 
    end

    it "should return a nice string for nested metashes" do
      @nested.inspect.should eql('{nested: {key: :value}}')
    end

    it "should return a nice string for complex metashes" do
      @complex.inspect.should eql('{complex: {key1: :value1, key2: :value2}}')
    end

  end

end

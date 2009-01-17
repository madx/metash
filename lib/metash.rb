# A hash with method_missing implemented so you can make calls
# i.e.: hash.foo.bar => hash[:foo][:bar]
#       hash.foo "bar" => hash[:foo] = "bar"
class Metash
  instance_methods.each do |meth| 
    unless meth =~ /^__/
      undef_method meth
    end
  end

  def initialize(hash={})
    @hash = recurse(hash)
  end

  alias_method :orig_method_missing, :method_missing

  # Some method_missing magic is used to provide the nice interface.
  def method_missing(meth, *args)
    return nil if !@hash.key?(meth) && args.empty?
    if args.empty?
      @hash[meth]
    else
      @hash[meth] = args.size == 1 ? args.first : args
    end
  end

  # Different inspect method to distinguish from Hash
  def inspect
  end

  private

  def recurse(hash)
    hash.each do |key,val|
      hash[key] = val.instance_of?(Hash) ? Metash.new(val) : val
    end
    hash
  end
  
end

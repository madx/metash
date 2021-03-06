# A hash with method_missing implemented so you can make calls
# i.e.: hash.foo.bar => hash[:foo][:bar]
#       hash.foo "bar" => hash[:foo] = "bar"
class Metash
  instance_methods.each do |meth| 
    unless meth =~ /(^__)|(\?$)|^instance_eval$/
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

  # Returns the internal hash, it may be useful
  def __hash
    @hash
  end

  # A Hash-like inspect
  def inspect
    strs = []
    @hash.each do |key, val|
      strs << "%s: %s" % [key, val.inspect]
    end
    "{%s}" % strs.join(', ')
  end

  private
  def recurse(hash)
    hash.each do |key,val|
      hash[key] = val.instance_of?(Hash) ? Metash.new(val) : val
    end
    hash
  end
  
end

class DotOptions
  attr_reader :_options
  attr_accessor :_key, :_parent, :_full_path

  def initialize(base_options = nil, &block)
    @_key = nil
    @_parent = nil
    @_options = []
    @_full_path = []
    _build_options(base_options || {})
    instance_eval(&block) if block
  end

  def [](key)
    _options.include?(key.to_sym) ? send(key.to_sym) : nil
  end

  def inspect
    "<#{_options.map { |key| "#{key}: #{send(key).inspect}" }.join(', ')}>"
  end

  def to_s
    _flat_options.map { |key, value| "#{key} = #{value.inspect}" }.join "\n"
  end

  def to_h
    _options.to_h do |key|
      value = send key
      value = value.to_h if value.is_a? DotOptions
      [key, value]
    end
  end

protected

  def _flat_options(prefix = nil)
    result = {}
    _options.each do |key|
      value = send key
      full_key = [prefix, key].compact.join('.')
      opts = value.is_a?(DotOptions) ? value._flat_options(full_key) : { full_key => value }
      result.merge! opts
    end
    result
  end

private

  def _build_options(options)
    options.each do |key, value|
      _define_accessor key
      if value.is_a? Hash
        value = DotOptions.new value
        value._full_path = _full_path + [key]
        value._key = key
        value._parent = self
      end

      send :"#{key}=", value
    end
  end

  def _define_accessor(key)
    raise NameError, "invalid attribute name `#{key}'" unless key.respond_to?(:to_sym)

    _options.push key.to_sym
    singleton_class.class_eval do
      attr_accessor key.to_sym
    end
  end
end

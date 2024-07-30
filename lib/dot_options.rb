class DotOptions
  OptionNotFoundError = Class.new StandardError

  attr_reader :options, :key, :parent

  def initialize(options = {}, key: nil, parent: nil)
    @options = options
    @key = key
    @parent = parent
    build_options
  end

  def inspect
    "{ #{options.map { |key, value| "#{key}: #{value.inspect}" }.join(', ')} }"
  end

  def to_s
    flat_options.map { |key, value| "#{key} = #{value.inspect}" }.join "\n"
  end

  def flat_options(prefix = nil)
    result = {}
    options.each do |key, value|
      full_key = [prefix, key].compact.join '.'
      opts = value.is_a?(DotOptions) ? value.flat_options(full_key) : { full_key => value }
      result.merge! opts
    end

    result
  end

  def method_missing(name, *args)
    if name.to_s.end_with?('=')
      key = name.to_s.chomp('=').to_sym
      options[key] = args.first
      build_options if args.first.is_a? Hash
    elsif options.has_key? name
      options[name]
    else
      raise OptionNotFoundError, "Option '#{full_path(name)}' not found"
    end
  end

  def respond_to_missing?(name, include_private = false)
    options.has_key?(name.to_s.chomp('=').to_sym) || super
  end

private

  def build_options
    options.each do |key, value|
      options[key] = DotOptions.new(value, key: key, parent: self) if value.is_a?(Hash)
    end
  end

  def full_path(name)
    ancestors = [name]
    current = self
    while current.is_a? DotOptions
      ancestors.unshift(current.key) if current.key
      current = current.parent
    end

    ancestors.join '.'
  end
end
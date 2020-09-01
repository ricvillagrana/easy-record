module Field
  def field(name, type, **options)
    self.instance_variable_set('@_defaults', {})\
      if self.instance_variable_get('@_defaults').nil?

    attr_reader name
    generate_method(name, type, options)

    unless options[:default].nil?
      data = self.instance_variable_get('@_defaults')
        .merge("#{name}": options[:default])
      self.instance_variable_set('@_defaults', data)
    end
  end

  def generate_method(name, type, options)
    self.define_method("#{name}=") do |value|
      if Field.validate(value, type)
        if options[:null] == false && value == nil
          raise "#{name} cannot receive type `nil` because it is defined as `null: false`"
        end

        instance_variable_set("@#{name}", value)
      else
        raise "#{name} cannot receive type `#{value.class}` because it is defined as `#{type}`"
      end
    end
  end

  def self.validate(value, type)
    return true if value == nil

    if type == :boolean
      return value.class == TrueClass || value.class == FalseClass
    end

    value.class == type
  end
end

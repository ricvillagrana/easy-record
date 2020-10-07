# frozen_string_literal: true

module Field
  def field(name, type, **options)
    default_option = options[:default]

    instance_variable_set('@_defaults', {})\
      if instance_variable_get('@_defaults').nil?

    attr_reader name

    generate_method(name, type, options)
    return if default_option.nil?

    data = instance_variable_get('@_defaults').merge("#{name}": default_option)
    instance_variable_set('@_defaults', data)
  end

  def generate_method(name, type, options)
    define_method("#{name}=") do |value|
      unless Field.validate(value, type)
        raise "#{name} cannot receive type `#{value.class}` because it is defined as `#{type}`"
      end

      if !options[:null] && value.nil?
        raise "#{name} cannot receive type `nil` because it is defined as `null: false`"
      end

      instance_variable_set("@#{name}", value)
    end
  end

  def self.validate(value, type)
    return true if value.nil?

    return value.class == TrueClass || value.class == FalseClass if type == :boolean

    value.class == type
  end
end

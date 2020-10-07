# frozen_string_literal: true

module Association
  # rubocop:disable Naming/PredicateName
  def has_many(name, model_name = nil)
    model_name ||= { class_name: Dry::Inflector.new.classify(name) }

    if model_name.keys.first == :class_name
      has_many_directly(name, model_name)
    else
      has_many_through(name, model_name)
    end
  end

  def belongs_to(name, model = nil, target_id = nil)
    target ||= "#{name}"
    model_name = model&[:class_name] || Dry::Inflector.new.classify(name)


    relate_target(target)

    define_method(name) do
      Object.const_get(model_name).all.find do |m|
        m.id == send("#{target}_id")
      end
    end
  end

  private

  def has_many_directly(name, model_name)
    define_method(name) do
      Object.const_get(model_name[:class_name]).all.select do |m|
        m.send("#{self.class.name.snakecase}_id") == @id
      end
    end
  end

  def has_many_through(name, common_model_name)
    define_method(name) do
      pivot_records = send(common_model_name[:through].to_s).select do |m|
        m.send("#{self.class.name.snakecase}_id") == @id
      end

      pivot_records.map { |m| m.send(name.to_s) }.flatten
    end
  end

  def relate_target(target)
    target = target.to_s

    relate(target)
    relate_with_postfix(target)
  end

  def relate(target)
    send(:define_method, "#{target}_id=") do |value|
      instance_variable_set("@#{target}_id", value)
    end

    send(:define_method, "#{target}_id") do
      instance_variable_get("@#{target}_id")
    end
  end

  def relate_with_postfix(target)
    send(:define_method, "#{target}=") do |value|
      instance_variable_set("@#{target}_id", value.id)
    end

    send(:define_method, "#{target}") do
      instance_variable_get("@#{target}")
    end
  end
  # rubocop:enable Naming/PredicateName
end

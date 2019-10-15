module Association
  def has_many(name, model_name)
    if model_name.keys.first == :class_name
      has_many_directly(name, model_name)
    else
      has_many_through(name, model_name)
    end
  end

  def belongs_to(name, model, target_id)
    relate_target(target_id)

    self.define_method(name) do
      Object.const_get(model[:class_name]).all.find do |m|
        m.id == self.send(target_id.to_s)
      end
    end
  end

  private

  def has_many_directly(name, model_name)
    self.define_method(name) do
      Object.const_get(model_name[:class_name]).all.select do |m|
        m.send("#{self.class.name.snakecase}_id") == @id
      end
    end
  end

  def has_many_through(name, common_model_name)
    self.define_method(name) do
      self.send(common_model_name[:through]).select do |m|
        m.send("#{self.class.name.snakecase}_id") == @id
      end.map { |m| m.send(name.to_s) }.flatten
    end
  end

  def relate_target(target_id)
    self.send(:define_method, "#{target_id}=".to_sym) do |value|
      instance_variable_set("@" + target_id.to_s, value)
    end

    self.send(:define_method, target_id.to_sym) do
      instance_variable_get("@" + target_id.to_s)
    end
  end
end

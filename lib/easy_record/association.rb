module Association
  def has_many(name, model_name)
    if model_name.keys.first == :class_name
      has_many_directly(name, model_name)
    else
      has_many_through(name, model_name)
    end
  end

  def belongs_to(name, model, target_id)
    self.define_method(name) do
      binding.pry
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
end

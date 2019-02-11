module Association
  def has_many(name, model_name)
    # Determinate if second param is a class_name or a through class
    if model_name.keys.first == :class_name
      has_many_simple(name, model_name)
    else
      has_many_through(name, model_name)
    end
  end

  def belongs_to(name, model, target_id)
    self.define_method(name) do
      Object.const_get(model[:class_name]).all.find { |m| m.id == self.send(target_id.to_s) }
    end
  end

  private

  def has_many_simple(name, model_name)
    # Create method named as the param name says.
    self.define_method(name) do
      # Select those that has the same id that current model_name.
      Object.const_get(model_name[:class_name]).all.select do |m|
        # Return true when target id is equal to slef id
        m.send("#{self.class.name.snakecase}_id") == @id
      end
    end
  end

  def has_many_through(name, common_model_name)
    # Create method with the name of model
    self.define_method(name) do
      # Get all related transition records with select Enumerable
      self.send(common_model_name[:through]).select do |m|
        # Return array of target records
        m.send("#{self.class.name.snakecase}_id") == @id
      end.map { |m| m.send(name.to_s) }.flatten # Flat the array of array to an array of records
    end
  end
end

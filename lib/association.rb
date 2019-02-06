class Association
  require 'forwardable'

  def has_many(name, model)
    if model.is_a?(Hash)
      has_many_through(name, model)
    else
      has_many_simple(name, model)
    end
  end

  def belongs_to(name, model, target_id)
    self.class.define_method(name) do
      model.all.find { |m| m.id == self.send(target_id.to_s) }
    end
  end

  private

  def has_many_simple(name, model)
    # Creates method named as the param name says.
    self.class.define_method(name) do
      # Select those that has the same id that current model.
      model.all.select { |m| m.send("#{self.class.name.snakecase}_id") == @id }
    end
  end

  def has_many_through(name, common_model)
    p common_model
    self.class.define_method(name) do
      self.send(common_model[:through]).select do |m|
        m.send("#{self.class.name.snakecase}_id") == @id
      end.map { |m| m.send(name.to_s) }.flatten
    end
  end
end

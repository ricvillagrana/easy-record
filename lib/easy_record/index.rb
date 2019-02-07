module Index
  # Initilialize $indexes
  $indexes = {} unless defined? $indexes

  def self.next_id(model = nil)
    # If model was not privided just exit
    return if model.nil?

    # map indexes of $indexes to know if the model is alredy in it.
    if $indexes.map(&:first).include?(model.class.name)
      # If so, increment
      $indexes[model.class.name] += 1
    else
      # Otherwise initialize with 1
      $indexes[model.class.name] = 1
    end
    # return the current index
    $indexes[model.class.name]
  end
end

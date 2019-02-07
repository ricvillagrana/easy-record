module Record
  # Initialize $records
  $records = {} unless defined? $records

  def self.track(instance = nil)
    # If model was not provided just exit.
    return if instance.nil?

    # mao indexes of $records and know if model is alredy in it.
    if $records.map(&:first).include?(instance.class.name)
      # If so, push the new record on array,
      $records[instance.class.name].push(instance)
    else
      # Otherwise initilize it with the record
      $records[instance.class.name] = [instance]
    end
  end

  def self.untrack(instance)
    # Delete the record from tracked records
    index = $records.index(instance)
    $records.delete_at(index) unless index.nil?
    $records
  end

  def self.of(class_name)
    # Return array of records of provided class_name
    $records[class_name]
  end
end

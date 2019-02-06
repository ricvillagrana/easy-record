module Index
  $indexes = {} unless defined? $indexes

  def self.next_id(model = nil)
    return if model.nil?

    if $indexes.map(&:first).include?(model.class.name)
      $indexes[model.class.name] += 1
    else
      $indexes[model.class.name] = 1
    end
    $indexes[model.class.name]
  end
end

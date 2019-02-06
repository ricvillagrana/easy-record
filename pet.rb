class Pet < Application
  attr_accessor :name, :color, :person_id
  def associate
    belongs_to(:owner, Person, :person_id)
    has_many(:toys, Toy)
  end
end

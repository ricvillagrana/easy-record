class Person < Application
  attr_accessor :name, :age
  def associate
    has_many(:pets, Pet)
    has_many(:toys, through: :pets)
  end
end

class Person < Application
  attr_accessor :name, :age
  has_many :pets, class_name: 'Pet'
  has_many :toys, through: :pets
end

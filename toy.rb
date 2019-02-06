class Toy < Application
  attr_accessor :name, :pet_id
  belongs_to(:owner, Pet, :pet_id)
end

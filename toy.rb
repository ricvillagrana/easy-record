class Toy < Application
  attr_accessor :name, :pet_id
  def associate
    belongs_to(:owner, Pet, :pet_id)
  end
end

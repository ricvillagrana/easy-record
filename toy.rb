class Toy < EasyRecord
  attr_accessor :name, :pet_id
  belongs_to :owner, { class_name: 'Pet' }, :pet_id
end

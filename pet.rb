class Pet < Application
  attr_accessor :name, :color, :person_id
  belongs_to :owner, { class_name: 'Person' }, :person_id
  has_many :toys, class_name: 'Toy'
end

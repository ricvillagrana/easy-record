# frozen_string_literal: true

require_relative '../lib/easy_record'

class Person < EasyRecord
  attr_accessor :name, :age

  has_many :pets, class_name: 'Pet'
  has_many :toys, through: :pets
end

class Pet < EasyRecord
  attr_accessor :name, :color, :person_id

  belongs_to :owner, { class_name: 'Person' }, :person_id
  has_many :toys, class_name: 'Toy'
end

class Toy < EasyRecord
  attr_accessor :name, :pet_id

  belongs_to :owner, { class_name: 'Pet' }, :pet_id
end

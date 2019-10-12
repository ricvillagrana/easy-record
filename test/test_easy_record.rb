# frozen_string_literal: true

require 'minitest/autorun'
require_relative './example_classes'

# Test examples from Easy Record readme
class TestEasyRecord < Minitest::Test
  def setup
    @person = Person.new
    @pet = Pet.new
    @toy = Toy.new
  end

  def test_assigning_a_person_to_a_pet_results_in_two_way_relation
    @pet.person_id = @person.id

    assert_equal [@pet], @person.pets
    assert_equal @person, @pet.owner
  end
end

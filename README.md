# Easy Record

## Features
- [x] Models associations
  - [x] `belongs_to`
  - [x] `has_many`
  - [x] `has_many :through`
- [ ] Save to disk (as JSON)
- [ ] Restore from disk (JSON files)

## Model definition
```ruby
class Person < Application
  attr_accessor :name, :age

  has_many :pets, class_name: 'Pet'
  has_many :toys, through: :pet
end

class Pet < Application
  attr_accessor :name, :color, :person_id

  belongs_to :owner, { class_name: 'Person' }, :person_id
  has_many :toys, class_name: 'Toy'
end

class Toy < Application
  attr_accessor :name, :pet_id

  belongs_to(:owner, Pet, :pet_id)
end
```

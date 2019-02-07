# Easy Record
Easy Record (easy_record) is a lightweight gem based on ActiveRecord, you can relate models only so
far, but check te Features / Known issues to see what is planned to do. You can also open issues and
PRs.

## Installing
From terminal

`gem install easy-record`

In Gemfile

`gem 'easy-record', '~> 0.1.0'`

## Features / Known issues
- [x] Models associations.
  - [x] `belongs_to`.
  - [x] `has_many`.
  - [x] `has_many :through`.
- [ ] Relate models easier.
- [ ] Save to disk (as JSON).
- [ ] Restore from disk (JSON files).

## Usage
```ruby
require 'easy_record'
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

  belongs_to(:owner, Pet, :pet_id)
end
```

Now you can do something like this:

```ruby
person = Person.new
pet = Pet.new
toy = Toy.new

pet.person_id = person.id

person.pets # => Array of peths

toy.pet_id = pet.id

person.toys # => Array of toys
pet.toys # => Array of toys

toy.owner.owner # => person
```


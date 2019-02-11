# Easy Record
#### v0.1.1.alpha2
Easy Record (easy_record) is a lightweight gem based on ActiveRecord, you can relate models only so
far, but check te Features / Known issues to see what is planned to do. You can also open issues and
PRs.

## Installation
From terminal

`gem install easy-record`

In Gemfile

`gem 'easy-record', '~> 0.1.1.alpha2'`

## Features / Known issues
- [x] Models associations.
  - [x] `belongs_to`.
  - [x] `has_many`.
  - [x] `has_many :through`.
- [x] Initialize with hash values.
- [ ] Relate models easier.
- [x] Save to CSV
  - [x] Save to disk (as CSV).
  - [x] Restore from disk (CSV files).
  - [x] Save a single instance (append).
  - [x] Update a single instance (Rewrite only those records that are saved).
  - [x] Delete single records and untrack them.
- [ ] Save to JSON
  - [ ] Save to disk (as JSON).
  - [ ] Restore from disk (JSON files).
  - [ ] Save a single instance (append).
  - [ ] Update a single instance (Rewrite only those records that are saved).
  - [ ] Delete single records and untrack them.

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

## Save
```ruby
ClassName.save_to_csv # Will save all tracked instances
ClassName.load_from_csv # Will load and track all rows in csv (CSV has headers)

instance.save # Not working yet
```


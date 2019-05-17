# Easy Record

Easy Record (easy_record) is a lightweight gem based on ActiveRecord, you can relate models only so
far, but check te Features / Known issues to see what is planned to do. You can also open issues and
PRs.

[![Build with Ruby](http://img.shields.io/badge/made%20with-Ruby-7f1c1f.svg?style=for-the-badge&logo=ruby&labelColor=c1282c)](https://www.ruby-lang.org/)

[![Buy me a coffee](https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png)](https://www.buymeacoffee.com/ricvillagrana)

## Installation
From terminal

`gem install easy-record`

In Gemfile

`gem 'easy-record', '~> 0.2.0'`

## Features / Known issues
- [x] Models associations.
  - [x] `belongs_to`.
  - [x] `has_many`.
  - [x] `has_many :through`.
- [x] Initialize with hash values.
- [ ] Relate models easier.
- [ ] Save to JSON
  - [ ] Save to disk (as JSON).
  - [ ] Restore from disk (JSON files).
  - [ ] Save a single instance (append).
  - [ ] Update a single instance (Rewrite only those records that are saved).
  - [ ] Delete single records and untrack them.
- [ ] Soft delete

## Usage

### Models definitions
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

  belongs_to :owner, { class_name: 'Pet' }, :pet_id
end
```

### Models usage

```ruby
person = Person.new
pet = Pet.new
toy = Toy.new

pet.person = person
# or
person.pets.append(pet)

person.pets # => Array of peths
pet.owner # => person

toy.pet = pet
# or
pet.toys.append(toy)

person.toys # => Array of toys
pet.toys # => Array of toys

toy.owner.owner # => person
```

### Saving
```ruby
ClassName.save_all # Will save all tracked instances
ClassName.load_all # Will load and track all rows

instance.save
instance.destroy
```

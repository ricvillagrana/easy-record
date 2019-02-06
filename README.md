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

  def associate
    has_many :pets, Pet # Pet class should exists
  end
end
```

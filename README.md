# Easy Record

Easy Record (easy_record) is a lightweight gem based on ActiveRecord, you can relate models only so
far, but check te Features / Known issues to see what is planned to do. You can also open issues and
PRs.

[![Build with Ruby](http://img.shields.io/badge/made%20with-Ruby-7f1c1f.svg?style=for-the-badge&logo=ruby&labelColor=c1282c)](https://www.ruby-lang.org/)

<a id="preview-btn" target="_blank" href="https://peachpay.me/ricardo/payme" style="background-color: rgb(255, 124, 113); background-image: url(&quot;https://peachpay.me/packs/peachpay-lgg-83178e076a5ada0d183a2344d48d63d4.svg&quot;) !important; background-repeat: no-repeat; border-radius: 2px; font-family: &quot;Open Sans&quot;, sans-serif; min-width: 40px; max-width: 320px; text-decoration: none; border: 0px; color: white !important; display: block; height: max-content; width: max-content; background-position: 6px 7px; background-size: 17px; font-size: 11px; padding: 8px 8px 8px 25px;">Donate PeachPay</a>

## Installation
From terminal

`gem install easy-record`

In Gemfile

`gem 'easy-record', '~> 0.2.0'`

## Usage

### Models definitions
```ruby
require 'easy_record'

class User < EasyRecord
  field :age, Integer, null: false
  field :name, String

  has_many :lists
  has_many :tasks, through: :lists

  def tasks_left
    self.tasks.select { |task| !task.done }
  end
end

class List < EasyRecord
  field :name, String

  belongs_to :owner, { class_name: 'User' }, :user_id
  has_many :tasks
end

class Task < EasyRecord
  field :name, String
  field :done, :boolean, default: false

  belongs_to :list

  def toggle
    @done = !@done
  end
end
```

### Models usage

```ruby
user = User.new(name: "test")
list = List.new(user_id: user.id)
5.times do |i|
  Task.new(name: "Task ##{i}", list_id: list.id)
end

user.tasks_left
user.tasks.first.toggle
user.tasks_left

puts User.pluck(:name)
puts User.pluck(:name, :id)
puts User.count

# Validations
# User name field is declared as String so it cannot contain a Integer or any other type.
user.name = 2 # <- Will raise  name cannot receive type `Integer` because it is defined as `String`
user.name = nil # This works
user.age = "Three" # <- Will raise age cannot receive type `Sting` because it is defined as `Integer`
user.age = nil # <- Will raise age cannot receive type `nil` because it is defined as `null: false`
```

### The `field` method usage
`field` can take up to three arguments, the first one is the name of the field, the second one is the Type (May be any class or `:boolean` for true/false) and the last one is the options hash.
Example:
```ruby
class Something < EasyRecord
   field :name, String, default: 'someone'
end
```
#### Name
It is just the name of the field and how you will access to it and how to update it. It creates a `attr_reader` and a method to assign new values (`#{name}=`).

#### Type
The type can be any class (Ruby standard classes or custom classes) and it will automatically validate.

#### Options
**default**: the default value of the field when no data is given.
**null**: the null option takes a boolean value and validates if the value is null or not, default value is true, so if you need a value to not be nil, do `null: false`.

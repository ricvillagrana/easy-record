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

## Usage

### Models definitions
```ruby
require 'easy_record'
class User < EasyRecord
  attr_accessor :name

  has_many :lists, class_name: 'List'
  has_many :tasks, through: :lists

  def tasks_left
    self.tasks.select { |task| !task.done }
  end
end

class List < EasyRecord
  attr_accessor :name

  belongs_to :user, { class_name: 'User' }, 'user_id'
  has_many :tasks, class_name: 'Task'
end

class Task < EasyRecord
  attr_accessor :name, :done

  belongs_to :list, { class_name: 'List' }, 'list_id'

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
```

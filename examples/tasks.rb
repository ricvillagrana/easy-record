require_relative '../lib/easy_record'

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

puts list.user_id

binding.pry


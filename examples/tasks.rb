require_relative '../lib/easy_record'

class User < EasyRecord
  field :name, String
  field :age, Integer, null: false

  has_many :lists
  has_many :tasks, through: :lists

  def tasks_left
    self.tasks.select { |task| !task.done }
  end
end

class List < EasyRecord
  field :name, String

  belongs_to :user
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

user = User.new(name: "test", age: 20)
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


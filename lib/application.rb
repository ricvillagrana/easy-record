class Application < Association
  require 'snake_camel'
  require_relative './application/record'
  require_relative './application/index'

  attr_reader :id

  def self.all
    Record.of(self.to_s)
  end

  def self.first
    self.all.first
  end

  def self.last
    self.all.last
  end

  #private

  def initialize(args = nil)
    associate
    Record.track(self)
    @id = Index.next_id(self)
  end


end

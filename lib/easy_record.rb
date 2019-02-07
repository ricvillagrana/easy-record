require_relative './application/record'
require_relative './application/index'
require_relative './application/association'

class EasyRecord
  require 'snake_camel'

  extend Association
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

  def initialize(args = nil)
    Record.track(self)
    @id = Index.next_id(self)
  end


end

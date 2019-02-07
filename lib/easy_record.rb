require_relative './easy_record/record'
require_relative './easy_record/index'
require_relative './easy_record/association'

class EasyRecord
  require 'snake_camel'
  require 'pry'

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

  def initialize(attributes = nil)
    Record.track(self)
    @id = Index.next_id(self)

    set_attributes(attributes)
  end

  private

  def set_attributes(attributes)
    attributes.each { |key, value| set(key, value) } if attributes.is_a?(Hash)
  end

  def set(key, value)
    self.send("#{key}=", value)
  end

end

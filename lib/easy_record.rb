require_relative './easy_record/record'
require_relative './easy_record/association'
require_relative './easy_record/storage'

class EasyRecord
  require 'snake_camel'
  require 'pry'
  require 'UUID'

  extend Association
  include Storage

  attr_accessor :id

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

    set_attributes(attributes)
    set(:id, UUID.generate) unless attributes.keys.include?('id')
  end

  private

  def set_attributes(attributes)
    attributes.each { |key, value| set(key, value) } if attributes.is_a?(Hash)
  end

  def set(key, value)
    self.send("#{key}=", value)
  end

end

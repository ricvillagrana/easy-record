# frozen_string_literal: true

require_relative './easy_record/record'
require_relative './easy_record/association'
require_relative './easy_record/storage'
require_relative './easy_record/field'

class EasyRecord
  require 'snake_camel'
  require 'pry'
  require 'uuid'
  require 'dry/inflector'

  extend Association
  extend Field
  include Storage

  attr_accessor :id

  class << self
    def all
      Record.of(to_s)
    end

    def pluck(*attributes)
      return [] if attributes.length.eql?(0)
      return all.collect { |record| record.send(attributes.first) } if attributes.length.eql?(1)

      all.collect do |record|
        attributes.collect do |attr|
          record.send(attr)
        end
      end
    end

    def count
      all.length
    end

    def ids
      all.collect(&:id)
    end

    def first
      all.first
    end

    def last
      all.last
    end
  end

  def initialize(attributes = nil)
    Record.track(self)

    set_attributes(self.class.instance_variable_get(:@_defaults))
    set_attributes(attributes)
    set(:id, UUID.generate)
  end

  private

  def set_attributes(attributes)
    attributes.each { |key, value| set(key, value) } if attributes.is_a?(Hash)
  end

  def set(key, value)
    send("#{key}=", value)
  end
end

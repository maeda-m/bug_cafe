# frozen_string_literal: true

class PlainRecord
  def initialize(attrs = {})
    attrs.each { |k, v| send("#{k}=", v) }
  end
end

class Order < PlainRecord
  attr_accessor :id, :details

  def add_item(item, quantity = 1)
    @details ||= []

    @details << OrderLine.new(item: item, quantity: quantity)
  end

  def total_amount
    @details.sum(&:price)
  end
end

class OrderLine < PlainRecord
  attr_accessor :id, :item, :quantity

  def price
    item.unit_price * quantity
  end
end

class Item < PlainRecord
  attr_accessor :id, :name, :unit_price, :unit_name

  class << self
    def all
      @records ||= records.map { |attrs| new(attrs) }
    end

    def find(record_id)
      all.find { |r| r.id == record_id }
    end

    def create(attrs)
      record = new(attrs)

      @records ||= []
      @records << record

      record
    end

    def records; end
  end
end

class Drink < Item
  def self.records
    [
      { id: 1, name: 'コーヒー', unit_price: 300 },
      { id: 2, name: 'カフェラテ', unit_price: 400 },
      { id: 3, name: 'チャイ', unit_price: 460 },
      { id: 4, name: 'エスプレッソ', unit_price: 340 },
      { id: 5, name: '緑茶', unit_price: 450 }
    ].freeze
  end
end

class Food < Item
  def self.records
    [
      { id: 1, name: 'チーズケーキ', unit_price: 470 },
      { id: 2, name: 'アップルパイ', unit_price: 520 },
      { id: 3, name: 'ホットサンド', unit_price: 410 }
    ].freeze
  end
end

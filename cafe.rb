# frozen_string_literal: true

require 'debug'

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

module UseCase
  def take_order(klass)
    records = klass.all

    Decorator.choices(records)

    print '>'
    record_id = gets.to_i
    record = klass.find(record_id)

    Decorator.confirm(record)

    record
  end
  module_function :take_order

  module Decorator
    def choices(records)
      records.map do |r|
        puts "(#{r.id})#{r.name}: #{price(r)}"
      end
    end

    def confirm(record)
      puts "#{record.name}(#{price(record)})ですね。"
    end

    def price(record)
      "#{record.unit_price}円"
    end

    module_function :choices, :confirm, :price
  end
end

def main
  order = Order.new

  puts 'bugカフェへようこそ！ご注文は？ 番号でどうぞ'
  order1 = UseCase.take_order(Drink)
  order.add_item(order1)

  puts 'フードメニューはいかがですか?'
  order2 = UseCase.take_order(Food)
  order.add_item(order2)

  puts "お会計は#{order.total_amount}円になります。ありがとうございました！"
end

main if __FILE__ == $PROGRAM_NAME

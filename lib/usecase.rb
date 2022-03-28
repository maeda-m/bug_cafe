# frozen_string_literal: true

module Usecase
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

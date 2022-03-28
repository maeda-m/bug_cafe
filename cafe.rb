# frozen_string_literal: true

require_relative 'lib/order'
require_relative 'lib/usecase'

def main
  order = Order.new

  puts 'bugカフェへようこそ！ご注文は？ 番号でどうぞ'
  order1 = Usecase.take_order(Drink)
  order.add_item(order1)

  puts 'フードメニューはいかがですか?'
  order2 = Usecase.take_order(Food)
  order.add_item(order2)

  puts "お会計は#{order.total_amount}円になります。ありがとうございました！"
end

main if __FILE__ == $PROGRAM_NAME

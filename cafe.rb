# frozen_string_literal: true

DRINKS = [
  { name: 'コーヒー', price: 300 },
  { name: 'カフェラテ', price: 400 },
  { name: 'チャイ', price: 460 },
  { name: 'エスプレッソ', price: 340 },
  { name: '緑茶', price: 450 }
].freeze

FOODS = [
  { name: 'チーズケーキ', price: 470 },
  { name: 'アップルパイ', price: 520 },
  { name: 'ホットサンド', price: 410 }
].freeze

def take_order(menus)
  menus.each.with_index(1) do |menu, i|
    puts "(#{i})#{menu[:name]}: #{menu[:price]}円"
  end
  print '>'
  order_number = gets.to_i - 1
  ordered_item = menus[order_number]

  puts "#{ordered_item[:name]}(#{ordered_item[:price]}円)ですね。"
  ordered_item
end

def main
  puts 'bugカフェへようこそ！ご注文は？ 番号でどうぞ'
  ordered_drink = take_order(DRINKS)

  puts 'フードメニューはいかがですか?'
  ordered_food = take_order(FOODS)

  total = ordered_drink[:price] + ordered_food[:price]
  puts "お会計は#{total}円になります。ありがとうございました！"
end

main if __FILE__ == $PROGRAM_NAME

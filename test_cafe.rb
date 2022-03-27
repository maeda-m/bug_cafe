# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'cafe'

require 'debug'

def input_orders(drink:, food:)
  orders = [drink, food]
  def orders.gets
    pop
  end

  $stdin = orders
end

describe 'main' do
  it 'ドリンク (1)コーヒー: 300円 と フード (1)チーズケーキ: 470円 を注文する' do
    input_orders(drink: 1, food: 1)

    stdout = <<-EOF
bugカフェへようこそ！ご注文は？ 番号でどうぞ
(1)コーヒー: 300円
(2)カフェラテ: 400円
(3)チャイ: 460円
(4)エスプレッソ: 340円
(5)緑茶: 450円
>1
コーヒー(300円)ですね。
フードメニューはいかがですか?
(1)チーズケーキ: 470円
(2)アップルパイ: 520円
(3)ホットサンド: 410円
>1
チーズケーキ(470円)ですね。
お会計は770円になります。ありがとうございました！
    EOF
    assert_output(stdout) { main }
  end

  it 'ドリンク (3)チャイ: 460円 と フード (2)アップルパイ: 520円 を注文する' do
    input_orders(drink: 3, food: 2)

    stdout = <<-EOF
bugカフェへようこそ！ご注文は？ 番号でどうぞ
(1)コーヒー: 300円
(2)カフェラテ: 400円
(3)チャイ: 460円
(4)エスプレッソ: 340円
(5)緑茶: 450円
>3
チャイ(460円)ですね。
フードメニューはいかがですか?
(1)チーズケーキ: 470円
(2)アップルパイ: 520円
(3)ホットサンド: 410円
>2
アップルパイ(520円)ですね。
お会計は970円になります。ありがとうございました！
    EOF
    assert_output(stdout) { main }
  end

  it 'ドリンク (5)緑茶: 450円 と フード (3)ホットサンド: 410円 を注文する' do
    input_orders(drink: 5, food: 3)

    stdout = <<-EOF
bugカフェへようこそ！ご注文は？ 番号でどうぞ
(1)コーヒー: 300円
(2)カフェラテ: 400円
(3)チャイ: 460円
(4)エスプレッソ: 340円
(5)緑茶: 450円
>5
緑茶(450円)ですね。
フードメニューはいかがですか?
(1)チーズケーキ: 470円
(2)アップルパイ: 520円
(3)ホットサンド: 410円
>3
ホットサンド(410円)ですね。
お会計は860円になります。ありがとうございました！
    EOF
    assert_output(stdout) { main }
  end
end

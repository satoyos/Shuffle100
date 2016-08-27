# coding: utf-8
require_relative 'spec_helper'

describe '取り札画面を表示する機能のテスト' do

  it 'アプリのタイトルが正しく表示される' do
    can_see(TITLE)
  end

  describe '「1文字めで選ぶ」が正しく機能する' do
    it '歌選択画面を開く' do
      click_element_of('UIATableCell', name: '取り札を用意する歌')
      can_see '歌を選ぶ'
    end
    it '1首目のセルを長押しすると、「わかころもてに…」の取り札画面が表示される' do
      first_cell = find_elements(:class_name, 'UIATableCell').first
      action = Appium::TouchAction.new.long_press(element: first_cell).release
      action.perform
      can_see('torifuda_view')
    end
    it '「閉じる」ボタンを押すと、取り札画面が閉じる' do
      button('閉じる').click
      can_see '歌を選ぶ'
    end

  end
end

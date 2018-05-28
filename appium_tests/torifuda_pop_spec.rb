# coding: utf-8
require_relative 'spec_helper'

describe '取り札画面を表示する機能のテスト' do

  it 'アプリのタイトルが正しく表示される' do
    current_screen_is TOP_TITLE
  end

  describe '「1文字めで選ぶ」が正しく機能する' do
    it '歌選択画面を開く' do
      goto_select_poem_screen
      current_screen_is STR_SELECT_POEM_SCREEN
    end
    it '1首目のセルを長押しすると、「わかころもてに…」の取り札画面が表示される' do
      long_press_first_cell
      can_see 'torifuda_view'
    end
    it '「閉じる」ボタンを押すと、取り札画面が閉じる' do
      sleep_while_animation
      click_button STR_CLOSE
      current_screen_is STR_SELECT_POEM_SCREEN
    end
  end
end

def long_press_first_cell
  first_cell = find_elements(:class_name, TYPE_CELL).first
  pointX = first_cell.location.x + first_cell.size.width/2
  pointY = first_cell.location.y + first_cell.size.height/2
  duration = 2000
  Appium::TouchAction.new.press(x: pointX, y: pointY).wait(duration).release.perform
end


# coding: utf-8
require_relative 'spec_helper'

describe '歌を選ぶテスト' do

  it 'アプリのタイトルが正しく表示される' do
    can_see(TITLE)
  end

  describe '「1文字めで選ぶ」が正しく機能する' do
    it '歌選択画面を開く' do
      click_element_of('UIATableCell', name: '取り札を用意する歌')
      can_see('歌を選ぶ')
    end
    it '「全て取消」を選ぶと、全く歌が選ばれていない状態になる' do
      button('全て取消').click
      can_see '0首'
    end
    it '「1字目で選ぶ」ボタンを押すことで、その画面に遷移する' do
      button('1字目で選ぶ').click
      can_see '一字決まりの歌'
      can_see '0首'
    end
    it '「一字決まりの歌」のセルをタップすると、7首の歌が選ばれる' do
      click_element_of('UIATableCell', name: 'just_one')
      can_see '7首'
    end
    it '歌選択画面に戻っても、7首選ばれていることが反映されている' do
      back
      can_see '歌を選ぶ'
      can_see '7首'
    end
    it 'トップ画面に戻っても、7首選ばれていることが反映されている' do
      back
      can_see 'トップ'
      can_see '7首'
    end
  end
end

# coding: utf-8
require_relative 'spec_helper'

describe '歌を検索するテスト' do

  it 'アプリのタイトルが正しく表示される' do
    current_screen_is TOP_TITLE
  end

  describe '検索窓に文字を入力すると、歌を絞り込むことができる' do
    it '歌選択画面を開く' do
      goto_select_poem_screen
      current_screen_is '歌を選ぶ'
    end
    it '検索窓に「秋」を入力すると、1番, 5番, 22番…という順に歌が選ばれていて、2番は選ばれない。' do
      fill_search_window_with_text '秋'
      cell_names = get_filtered_cell_names
      expect(cell_names.first).to eq '001'
      expect(cell_names[1]).to eq '005'
      expect(cell_names[2]).to eq '022'
      expect(cell_names.include? '002').to be false
    end
    it 'キーボードを隠す' do
      keyboard = find_element(:class_name, 'XCUIElementTypeKeyboard')
      keyboard.find_element(:name, 'Search').click
    end
    it '検索結果の歌をすべて「取り消し」にする' do
      click_button_to_cancel_all
    end
    it '元の画面に戻ると、選ばれている歌の数が88酒になっている' do
      click_back_button
      can_see '88首'
    end
  end
end

# coding: utf-8
require_relative 'spec_helper'

describe '歌を検索するテスト' do

  it 'アプリのタイトルが正しく表示される' do
    can_see(TITLE)
  end

  describe '検索窓に文字を入力すると、歌を絞り込むことができる' do
    it '歌選択画面を開く' do
      click_element_of('UIATableCell', name: '取り札を用意する歌')
      can_see('歌を選ぶ')
    end
    it '検索窓に「秋」を入力すると、1番, 5番, 22番…という順に歌が選ばれている。' do
      find_element(:accessibility_id, "search_text_field").send_keys "秋"
      cell_names = find_elements(:class_name, 'UIATableCell').map{|e| e.name}
      expect(cell_names.first).to eq '001'
      expect(cell_names[1]).to eq '005'
      expect(cell_names[2]).to eq '022'
    end
  end
end

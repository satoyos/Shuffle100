# coding: utf-8
require_relative 'spec_helper'


describe "ヘルプメニューのテスト" do

  it "アプリのタイトルが正しく表示される" do
    can_see(TITLE)
  end

  describe '用意したヘルプを一通り閲覧できる' do
    it 'helpボタンを押すと、ヘルプメニューが開く' do
      button('help').click
      can_see('ヘルプ')
    end

    it '「設定できること」画面を閲覧できる' do
      click_element_of('UIATableCell', name: '設定できること')
      expect(first_text_elem).not_to eq '設定できること'
    end

  end
end


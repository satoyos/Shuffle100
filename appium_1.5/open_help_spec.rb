# coding: utf-8
require_relative 'spec_helper'


describe 'ヘルプメニューのテスト' do
  DIALOGUE_MESSAGE_FOR_EVAL_APP = 'このアプリを評価するために、App Storeアプリを立ち上げますか？'

  it 'アプリのタイトルが正しく表示される' do
    can_see(TITLE)
  end

  describe '用意したヘルプを一通り閲覧できる' do
    it 'helpボタンを押すと、ヘルプメニューが開く' do
      button('help').click
      can_see('ヘルプ')
    end

    it '「設定できること」画面を閲覧できる' do
      click_element_of('UIATableCell', name: '設定できること')
      expect(first_text_elem.value).to eq '設定できること'
      back
    end

    it '「試合の流れ (通常モード)」画面を閲覧できる' do
      click_element_of('UIATableCell', name: '試合の流れ (通常モード)')
      expect(first_text_elem.value).to eq '試合の流れ (通常モード)'
      back
    end

    it '「初心者モード」とは？画面を閲覧できる' do
      click_element_of('UIATableCell', name: '「初心者モード」とは？')
      expect(first_text_elem.value).to eq '「初心者モード」とは？'
      back
    end

    it '「試合の流れ（初心者モード）」画面を閲覧できる' do
      click_element_of('UIATableCell', name: '試合の流れ (初心者モード)')
      expect(first_text_elem.value).to eq '試合の流れ (初心者モード)'
      back
    end

    it 'ノンストップ・モードとは？画面を閲覧できる' do
      click_element_of('UIATableCell', name: '「ノンストップ・モード」とは？')
      expect(first_text_elem.value).to eq 'ノンストップ・モードとは？'
      back
    end

    it '「このアプリを評価する」を選ぶと、ダイアログが起動する' do
      click_element_of('UIATableCell', name: 'このアプリを評価する')
      can_see(DIALOGUE_MESSAGE_FOR_EVAL_APP)
      alert_dismiss
      can_not_see(DIALOGUE_MESSAGE_FOR_EVAL_APP)
      back
    end
  end
end


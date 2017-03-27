# coding: utf-8
require_relative 'spec_helper'


describe 'ヘルプメニューのテスト' do
  DIALOGUE_MESSAGE_FOR_EVAL_APP = 'このアプリを評価するために、App Storeアプリを立ち上げますか？'

  it 'アプリのタイトルが正しく表示される' do
    can_see(TITLE)
  end

  shared_examples '元の画面に戻ることができる' do
    it '元の画面に戻ることができる' do
      click_back_button
      expect(first_text_elem.value).to eq 'ヘルプ'
    end
  end

  describe '用意したヘルプを一通り閲覧できる' do
    it 'helpボタンを押すと、ヘルプメニューが開く' do
      click_button('help')
      can_see('ヘルプ')
    end

    it '「設定できること」画面を閲覧できる' do
      click_element_with_text('設定できること')
      expect(first_text_elem.value).to eq '設定できること'
    end

    include_examples '元の画面に戻ることができる'

    it '「試合の流れ (通常モード)」画面を閲覧できる' do
      click_element_with_text('試合の流れ (通常モード)')
      expect(first_text_elem.value).to eq '試合の流れ (通常モード)'
    end

    include_examples '元の画面に戻ることができる'

    it '「初心者モード」とは？画面を閲覧できる' do
      click_element_with_text('「初心者モード」とは？')
      expect(first_text_elem.value).to eq '「初心者モード」とは？'
    end

    include_examples '元の画面に戻ることができる'

    it '「試合の流れ（初心者モード）」画面を閲覧できる' do
      click_element_with_text('試合の流れ (初心者モード)')
      expect(first_text_elem.value).to eq '試合の流れ (初心者モード)'
    end

    include_examples '元の画面に戻ることができる'

    it 'ノンストップ・モードとは？画面を閲覧できる' do
      click_element_with_text('「ノンストップ・モード」とは？')
      expect(first_text_elem.value).to eq 'ノンストップ・モードとは？'
    end

    include_examples '元の画面に戻ることができる'

    it '「このアプリを評価する」を選ぶと、ダイアログが起動する' do
      click_element_with_text('このアプリを評価する')
      can_see(DIALOGUE_MESSAGE_FOR_EVAL_APP)
      alert_dismiss
      can_not_see(DIALOGUE_MESSAGE_FOR_EVAL_APP)
    end

  end
end


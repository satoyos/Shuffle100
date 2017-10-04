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
      current_screen_is 'ヘルプ'
    end
  end

  describe '用意したヘルプを一通り閲覧できる' do
    it 'helpボタンを押すと、ヘルプメニューが開く' do
      click_button('help')
      current_screen_is 'ヘルプ'
    end

    it '「設定できること」画面を閲覧できる' do
      click_element_with_text('設定できること')
      current_screen_is('設定できること')
    end

    include_examples '元の画面に戻ることができる'

    it '「試合の流れ (通常モード)」画面を閲覧できる' do
      click_element_with_text('試合の流れ (通常モード)')
      current_screen_is '試合の流れ (通常モード)'
    end

    include_examples '元の画面に戻ることができる'

    it '「初心者モード」とは？画面を閲覧できる' do
      click_element_with_text('「初心者モード」とは？')
      current_screen_is '「初心者モード」とは？'
    end

    include_examples '元の画面に戻ることができる'


    it '「試合の流れ（初心者モード）」画面を閲覧できる' do
      click_element_with_text('試合の流れ (初心者モード)')
      current_screen_is '試合の流れ (初心者モード)'
    end

    include_examples '元の画面に戻ることができる'

    it 'ノンストップ・モードとは？画面を閲覧できる' do
      click_element_with_text('「ノンストップ・モード」とは？')
      current_screen_is 'ノンストップ・モードとは？'
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


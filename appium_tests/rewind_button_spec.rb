# coding: utf-8
require_relative 'spec_helper'

describe '巻き戻しボタンのテスト' do

  it 'アプリのタイトルが正しく表示される' do
    current_screen_is TOP_TITLE
  end
  it '序歌を読み上げ中に巻き戻しボタンを押すと、再生待ち状態になる' do
    open_game
    click_rewind_button
    can_see 'play'
  end
  it 'その状態でもう一度巻き戻しボタンを推すと、トップ画面に戻る' do
    click_rewind_button
    current_screen_is TOP_TITLE
  end

  describe '1首め以降の読み上げ時の動作' do
    it '2首目の上の句まで進む' do
      open_game
      click_forward_button # 序歌を跳ばし、1首目へ
      click_forward_button # 1首めの上の句をskip
      click_forward_button # 1首めの下の句もskip
      recite_screen_title_matches /\A2首め/
    end
    it '2首目の上の句の途中で巻き戻しボタンを押すと、再生待ち状態になる' do
      click_rewind_button
      can_see 'play'
    end
    it 'その状態でもう一度巻き戻しボタンを推すと、1首めの下の句に戻る' do
      click_rewind_button
      recite_screen_title_matches /\A1首め/
      recite_screen_title_matches /下の句/
    end
    it 'その状態でもう一度巻き戻しボタンを推すと、上の句へ' do
      click_rewind_button
      recite_screen_title_matches /上の句/
    end
    it 'その状態でもう一度巻き戻しボタンを推すと、序歌ではなくトップ画面に戻る' do
      click_rewind_button
      current_screen_is TOP_TITLE
    end
  end
end


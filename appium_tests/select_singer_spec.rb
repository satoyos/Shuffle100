# coding: utf-8
require_relative 'spec_helper'

STR_SELECT_SINGER_SCREEN = '読手を選ぶ'
STR_SINGER_VOCALOID = 'IA（ボーカロイド）'

describe '読手を選ぶテスト' do

  it 'アプリのタイトルが正しく表示される' do
    current_screen_is TOP_TITLE
  end

  describe '読手を選ぶと、それがホーム画面に反映される' do
    it '初期状態では、ボーカロイドが読手として選ばれている' do
      can_see(STR_SINGER_VOCALOID)
    end

    it 'ホーム画面で読手セルをタップすると、読手を設定する画面が開く' do
      goto_select_singer_screen
      current_screen_is STR_SELECT_SINGER_SCREEN
    end

    it '「いなばくん」を選んで、ホーム画面に戻ると、それが読手として設定されている' do
      set_singer_inaba_kun
      can_not_see STR_SINGER_VOCALOID
    end
  end
end

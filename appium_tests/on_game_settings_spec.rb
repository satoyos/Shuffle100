# coding: utf-8
require_relative 'spec_helper'

describe '試合途中で変更可能な設定のテスト' do

  it 'アプリのタイトルが正しく表示される' do
    can_see(TITLE)
  end

  describe '通常モードでの各種設定' do
    TITLE_FOR_ON_GAME_SETTINGS = 'いろいろな設定'
    DURATION_BETWEEN_KAMI_SHIMO = '上の句と下の句の間隔'
    CLOSE_ON_GAME_SETTINGS = '設定終了'
    DURATION_BETWEEN_SONGS = '歌と歌の間隔'
    TITLE_FOR_DURATION_BETWEEN_SONGS = '歌の間隔の変更'

    it 'トップ画面で歯車ボタンを押すと、各種設定画面が現れる' do
      button('gear').click
      can_see TITLE_FOR_ON_GAME_SETTINGS
    end
    it '通常モードの時には、「上の句と下の句の間隔」セルが表示されない' do
      can_not_see DURATION_BETWEEN_KAMI_SHIMO
    end
    it '設定を終了し、トップ画面に戻る' do
      button(CLOSE_ON_GAME_SETTINGS).click
      can_see TITLE
    end
    it '試合を開始し、序歌の読み上げ画面で歯車ボタンを押すと、各種設定画面が現れる' do
      open_game
      button('gear_button').click
      can_see TITLE_FOR_ON_GAME_SETTINGS
    end
    it '「歌と歌の間隔」のセルを押すと、歌間隔設定画面に遷移する' do
      click_element_of('UIATableCell', name: DURATION_BETWEEN_SONGS)
      can_see TITLE_FOR_DURATION_BETWEEN_SONGS
    end
  end
end

# coding: utf-8
require_relative 'spec_helper'

TITLE_FOR_ON_GAME_SETTINGS = 'いろいろな設定'
CLOSE_ON_GAME_SETTINGS = '設定終了'
DURATION_BETWEEN_KAMI_SHIMO = '上の句と下の句の間隔'

describe '試合途中で変更可能な設定のテスト(通常モード)' do

  it 'アプリのタイトルが正しく表示される' do
    can_see(TITLE)
  end

  describe '通常モードでの各種設定' do
    DURATION_BETWEEN_SONGS = '歌と歌の間隔'
    TITLE_FOR_DURATION_BETWEEN_SONGS = '歌の間隔の変更'

    it 'トップ画面で歯車ボタンを押すと、各種設定画面が現れる' do
      click_settings_button
      sleep 1
      current_screen_is TITLE_FOR_ON_GAME_SETTINGS
    end
    it '通常モードの時には、「上の句と下の句の間隔」セルが表示されない' do
      can_not_see DURATION_BETWEEN_KAMI_SHIMO
    end
    it '設定を終了し、トップ画面に戻る' do
      quit_settings_and_see TITLE
    end
    it '試合を開始し、序歌の読み上げ画面で歯車ボタンを押すと、各種設定画面が現れる' do
      open_game
      can_see JOKA
      click_settings_button
      current_screen_is TITLE_FOR_ON_GAME_SETTINGS
    end
    it '「歌と歌の間隔」のセルを押すと、歌間隔設定画面に遷移する' do
      click_element_with_text(DURATION_BETWEEN_SONGS)
      current_screen_is TITLE_FOR_DURATION_BETWEEN_SONGS
    end
    it '設定を終了し、序歌に戻る' do
      click_back_button
      quit_settings_and_see JOKA
    end
  end
end

describe '試合途中で変更可能な設定のテスト(初心者モード)' do
  it '初心者モードにする' do
    can_see('空札を加える')
    set_recite_mode_beginner
    can_not_see('空札を加える')
  end
  it '試合を開始し、早送りボタンを押して、1首めへ' do
    open_game
    click_forward_button
    recite_screen_title_matches /\A1首め/
  end
  it 'さらに早送りボタンを押して、下の句へ。' do
    click_forward_button
    recite_screen_title_matches /下の句/
  end
  it 'もう一度早送りボタンを押すと、「次はどうする？」画面になる' do
    click_forward_button
    current_screen_is WHATS_NEXT_STR
  end
  it '歯車ボタンを押すと、各種設定画面が現れる' do
    click_settings_button
    sleep 2
    current_screen_is TITLE_FOR_ON_GAME_SETTINGS
  end
  it '初心者モードでは、「上の句と下の句の間隔」セルがある' do
    can_see DURATION_BETWEEN_KAMI_SHIMO
  end
  it '上の句と下の句の間隔を設定する画面に移ると、「試しに聞いてみみる」ボタンがある' do
    click_element_with_text(DURATION_BETWEEN_KAMI_SHIMO)
    current_screen_is DURATION_BETWEEN_KAMI_SHIMO
    can_see '試しに聞いてみる'
  end
  it '元の「次はどうする？」画面まで戻る' do
    click_back_button
    quit_settings_and_see WHATS_NEXT_STR
  end

end



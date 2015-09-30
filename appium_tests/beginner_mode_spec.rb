# coding: utf-8
require_relative 'spec_helper'


describe "初心者モードのテスト" do

  it "アプリのタイトルが正しく表示される" do
    can_see(TITLE)
  end

  describe '「次はどうする？」画面での動作各員' do

    it '初心者モードをonにする' do
      can_see('空札を加える')
      beginner_mode_switch = elem_of_class('UIASwitch', name: '初心者モード(散らし取り)')
      beginner_mode_switch.click if beginner_mode_switch.value == 0
      can_not_see('空札を加える')
    end

    it '試合を開始し、早送りボタンを押して、1首めへ' do
      open_game
      button('forward').click
      expect(first_text_elem.value).to match_regex /\A1首め/
    end

    it 'さらに早送りボタンを押して、下の句へ。' do
      button('forward').click
      expect(first_text_elem.value).to match_regex /下の句/
    end

    it 'もう一度早送りボタンを押すと、「次はどうする？」画面になる' do
      button('forward').click
      expect(first_text_elem.value).to eq WHATS_NEXT_STR
    end

    it '「下の句をもう一度読む」ボタンを押すと、下の句の読み上げを繰り返す' do
      button('refrain_button').click
      expect(first_text_elem.value).to match_regex /\A1首め/
      button('forward').click # 早送りして、また「次はどうする？」画面に戻る
    end

    it '「取り札を見る」ボタンを押すと、取り札画面が表示される' do
      button('torifuda_button').click
      can_see('torifuda_view')
      button('閉じる').click # 取り札画面を閉じて、また「次はどうする？」画面に戻る
    end
  end
end

private

def open_quit_dialogue(label)
    button(label).click
    can_see(DIALOGUE_MESSAGE_FOR_QUIT)
end

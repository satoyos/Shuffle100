class WhatsNextScreen < PM::Screen
  include GameQuitDelegate

  title '次はどうする？'

  # BAR_BUTTON_SIZE = 28
  BAR_BUTTON_SIZE = 14

  attr_reader :layout

  def on_load
    @layout = WhatsNextLayout.new.tap{|l|
      l.sizes = app_delegate.sizes ? app_delegate.sizes :
          OH::DeviceSizeManager.select_sizes  # こっちはRSpecテスト用。
    }
    self.view = layout.view
    set_navigation_bar_buttons
    set_button_actions
  end

  private

  def set_navigation_bar_buttons
    set_nav_bar_button :right, {
        button: @exit_button =
            BarExitButton.create_with_square_size(BAR_BUTTON_SIZE)
    }
    set_nav_bar_button :left, {
        button: @gear_button =
            BarGearButton.create_with_square_size(BAR_BUTTON_SIZE)
    }
  end

  def set_button_actions
    layout.get(:refrain_button).on(:touch){
      puts '+ 「もう1回下の句」ボタンが押された！' if BW2.debug?
      close(next: :refrain)
    }
    layout.get(:next_poem_button).on(:touch){
      puts '+ 「次の歌へ！」ボタンが押された！' if BW2.debug?
      close(next: :next_poem)
    }
    layout.get(:torifuda_button).on(:touch){
      puts '+ 「取り札を見る」ボタンが押された！' if BW2.debug?
      show_torifuda
    }
    @gear_button.on(:touch){
      puts '+ 「いろいろな設定」ボタンが押された！' if BW2.debug?
      open_on_game_settings
    }
    @exit_button.on(:touch){
      puts '+ 終了ボタンが押された！' if BW2.debug?
      confirm_user_to_quit
    }
  end

  def open_on_game_settings
    open OnGameSettingsScreen.new, modal: true, nav_bar: true
  end

  def back_to_top_screen
    close(next: :back_to_top)
  end

  def show_torifuda
    open_modal FudaScreen.new(nav_bar: true).tap{|s|
                 s.fuda_str = parent_screen.poem.in_hiragana.shimo
                 s.nav_bar_title = parent_screen.poem.str_with_number_and_liner
               }
  end
end
class WhatsNextScreen < PM::Screen
  title '次はどうする？'

  BAR_BUTTON_SIZE = 28

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

  def confirm_user_to_quit
    UIAlertView.alert('試合を終了しますか？',
                      buttons: ['終了する', '続ける']
    ) do |button, button_index|
      if button == '終了する'
        puts '[quit] 試合を終了します' if BW2.debug?
        back_to_top_screen
      else
        puts '[continue] 試合を続行します' if BW2.debug?
      end
    end
  end

  def back_to_top_screen
    close(next: :back_to_top)
  end
end
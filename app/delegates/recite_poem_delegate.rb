module RecitePoemDelegate
  ACC_LABEL_QUIT_ALERT = 'quit_alert_view'


  def play_button_pushed(view)
    if self.current_player.playing?
      self.current_player.pause
      self.recite_poem_view.show_waiting_to_play
    else
      recite_poem
    end
  end

  def current_player_progress
    total = self.current_player.duration
    f = self.current_player.currentTime / total
#    ap "  - f = #{f}" if BW::debug?
    f
  end

  def forward_skip
    if self.current_player
      self.current_player.currentTime = self.current_player.duration - 0.01
      self.current_player.play
    end
  end

  def rewind_skip
    return unless self.current_player
    if self.current_player.currentTime > 0.0 # 再生途中の場合
      self.current_player.currentTime = 0.0
      self.current_player.pause
      self.recite_poem_view.show_waiting_to_play
      self.recite_poem_view.update_progress
    else
      if self.supplier.kami?
        return unless self.supplier.rollback_prev_poem
        go_back_to_prev_poem
      else
        self.supplier.step_back_to_kami
        go_back_to_kami
      end
    end
  end

  def open_on_game_settings(sender)
    puts "Let's start On_Game_Settings!" if BW::debug?
    play_button_pushed(nil) if self.current_player.playing?

    open OnGameSettingsScreen.new, modal: true, nav_bar: true
  end

  def quit_game
    puts '- Quit Button Pushed!' if BW::debug?
    if self.current_player.playing?
      self.current_player.pause
      self.recite_poem_view.show_waiting_to_play
    end

    BW::UIAlertView.new({
                            title: '試合を終了しますか？',
                            buttons: ['終了する', '続ける'],
                            cancel_button_index: 0,
                            accessibilityLabel: ACC_LABEL_QUIT_ALERT
                        }) do |alert|
      if alert.clicked_button.cancel?
        puts '[quit] 試合を終了します' if BW::debug?
        back_to_top_screen
      else
        puts '[continue] 試合を続行します' if BW::debug?
      end
    end.show
  end

  def back_to_top_screen
    close to_screen: :root
  end
end
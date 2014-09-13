module RecitePoemDelegate
  ACC_LABEL_QUIT_ALERT = 'quit_alert_view'


  def play_button_pushed(view)
    if current_player.playing?
      current_player.pause
      layout.show_waiting_to_play
    else
      recite_poem
    end
  end

  def current_player_progress
    total = current_player.duration
    current_player.currentTime / total
  end

  def forward_skip
    current_player.stop if current_player.playing?
    audioPlayerDidFinishPlaying(current_player, successfully: true)
  end

  def rewind_skip
    return unless current_player
    if current_player.currentTime > 0.0 # 再生途中の場合
      current_player.tap do  |player|
        player.currentTime = 0.0
        player.pause
      end
      layout.show_waiting_to_play
      layout.update_progress
    else
      if supplier.current_index > 0
        if supplier.kami?
          back_to_top_screen unless supplier.rollback_prev_poem
          go_back_to_prev_poem
        else
          supplier.step_back_to_kami
          transit_shimo_kami
        end
      else #詠んでいる歌が序歌の場合
        back_to_top_screen
      end
    end
  end

  def open_on_game_settings(sender)
    puts "Let's start On_Game_Settings!" if BW2.debug?
    play_button_pushed(nil) if self.current_player.playing?
    open OnGameSettingsScreen.new, modal: true, nav_bar: true
  end

  def quit_game
    puts '- Quit Button Pushed!' if BW2.debug?
    if current_player.playing?
      current_player.pause
      layout.show_waiting_to_play
    end

    confirm_user_to_quit
  end

  def back_to_top_screen
    close to_screen: :root
  end

  private

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

end
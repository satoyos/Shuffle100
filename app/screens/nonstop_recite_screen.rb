class NonstopReciteScreen < BeginnerReciteScreen
  title 'ノンストップモードの歌詠み'

  def audioPlayerDidFinishPlaying(player, successfully: flag)
    return unless flag

    puts '- 読み上げが無事に終了！(ノンストップ・モード)' if BW2.debug?
    layout.play_finished_successfully
    if supplier.kami?
      recite_shimo_without_pause
    else
      recite_next_poem_without_pause
    end
  end

  def on_appear
    AVAudioSession.sharedInstance.tap do |session|
      session.setCategory(AVAudioSessionCategoryPlayback, error: nil)
      session.setActive(true, error: nil)
    end
    add_remote_command_event
  end

  def add_remote_command_event
    MPRemoteCommandCenter.sharedCommandCenter.tap do |center|
      center.togglePlayPauseCommand.addTarget(self, action: 'remote_toggle_play_pause:')
      center.playCommand.addTarget(self, action: 'remote_play:')
      center.pauseCommand.addTarget(self, action: 'remote_pause:')
      center.nextTrackCommand.addTarget(self, action: 'remote_next_track:')
      center.previousTrackCommand.addTarget(self, action: 'remote_prev_track:')
    end
  end

  def remote_toggle_play_pause(event)
    current_player.playing ?
        current_player.pause :
        current_player.play
  end

  def remote_play(event)
    current_player.play
  end

  def remote_pause(event)
    current_player.pause
  end

  def remote_next_track(eveent)
    forward_skip
  end

  def remote_prev_track(event)
    rewind_skip
  end

  def did_enter_background
    puts 'xxxx Nonstopだから、バックグラウンドになっても再生を止めないよ！ xxxx' if BW2.debug?
  end

end
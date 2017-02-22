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
    AVAudioSession.sharedInstance.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
    AVAudioSession.sharedInstance.setActive(true, error: nil)
    self.beginReceivingRemoteControlEvents
  end

  def on_disappear
    self.endReceivingRemoteControlEvents
  end

  def beginReceivingRemoteControlEvents
    UIApplication.sharedApplication.beginReceivingRemoteControlEvents
    self.becomeFirstResponder
  end

  def endReceivingRemoteControlEvents
    UIApplication.sharedApplication.endReceivingRemoteControlEvents
    self.resignFirstResponder
  end

  def remoteControlReceivedWithEvent(event)
    if event.type == UIEventTypeRemoteControl
      puts "/// Received Event: [#{event.subtype}]"
      case event.subtype
        when 100; current_player.play
        when 101; current_player.pause
        when 104; forward_skip
        when 105; rewind_skip
        else
          puts "  今はまだこのRemoteControlイベント#{event.subtype}(#{event.subtype.class})は処理できない。。"
      end
    else
      puts "*** 何か分かれへんイベントやで。。。(´・ω・｀)"
    end
  end

end
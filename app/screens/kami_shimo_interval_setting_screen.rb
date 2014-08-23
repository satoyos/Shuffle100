class KamiShimoIntervalSettingScreen < IntervalSettingScreen
  title '上の句と下の句の間隔'

  def will_disappear
    puts ' - 上下interval_timeの値を %1.2f秒に書き換えます！' % interval_slider.value if BW2.debug?
    app_delegate.reciting_settings.kami_shimo_interval = interval_slider.value.round(2)
  end

  def audioPlayerDidFinishPlaying(player, successfully:flag)
    return unless flag
    puts '- 読み上げが無事に終了！' if BW2.debug?
    unless @kami_playing
      update_interval_label_text
      return
    end
    interval_count_down
  end

  private

  def set_kami_shimo_players
    supplier = PoemSupplier.new  # 間隔調節用に、全く新規のsupplierを作る
    supplier.draw_next_poem
    @kami_player = supplier.player.tap {|p| p.delegate = self}
    supplier.step_into_shimo
    @shimo_player = supplier.player.tap {|p| p.delegate = self}
  end

  def initial_interval_time
    app_delegate.reciting_settings.kami_shimo_interval
  end

  def try_button_pushed(button)
    puts "button #{button} is pushed (初心者モード)" if BW2.debug?
    puts "このとき、スライダーの値は[#{interval_slider.value}]" if BW2.debug?
    reset_players_if_needed
    @interval_time = interval_slider.value.round(2)
    kami_player.play
    @kami_playing = true
  end

  def shorten_last_time(timer)
    @last_time -= SHORTEN_INTERVAL
    interval_label.text = '%.02f' % @last_time
    if @last_time < SHORTEN_INTERVAL
      timer.invalidate
      interval_label.text = '%.02f' % 0.0
      NSLog '  - Timer END!' if BW2.debug?
      shimo_player.play
      @kami_playing = false
    end
  end
end
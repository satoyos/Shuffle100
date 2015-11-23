class IntervalSettingScreen < PM::Screen
  include OH::Notifications

  MIN_INTERVAL_VALUE = 0.5
  MAX_INTERVAL_VALUE = 2.0
  SHORTEN_INTERVAL = 0.02

  TRY_BUTTON_TITLE = '試しに聞いてみる'
  title '歌の間隔の変更'

  attr_reader :shimo_player, :kami_player, :interval_time
  attr_reader :layout, :slider, :interval_label

  def on_load
    set_kami_shimo_players

    @layout = IntervalSettingLayout.new.tap {|l|
      l.sizes = app_delegate.sizes ? app_delegate.sizes :
          OH::DeviceSizeManager.select_sizes # こっちはRSpecテスト用
    }
    self.view = layout.view
    @slider = layout.slider
    @interval_label = layout.int_label
    init_slider_value
    set_parts_actions
    set_font_changed_notification
  end

  def will_disappear
    puts ' - interval_timeの値を %1.2f秒に書き換えます！' % slider.value if BW2.debug?
    app_delegate.reciting_settings.interval_time = slider.value.round(2)
  end

  def should_autorotate
    false
  end

  def audioPlayerDidFinishPlaying(player, successfully:flag)
    return unless flag
    puts '- 読み上げが無事に終了！' if BW2.debug?
    if @kami_playing
      layout.update_interval_label
      return
    end
    interval_count_down
  end

  def shorten_last_time(timer)
    @last_time -= SHORTEN_INTERVAL
    interval_label.text = '%.02f' % @last_time
    if @last_time < SHORTEN_INTERVAL
      timer.invalidate
      interval_label.text = '%.02f' % 0.0
      NSLog '  - Timer END!' if BW2.debug?
      kami_player.play
      @kami_playing = true
    end
  end

  def slider_value_changed
    puts 'Sliderの値が変わったよ！' if BW2.debug?
    reset_players_if_needed
    layout.update_interval_label
  end

  def try_button_pushed
    puts "お試しボタン is pushed" if BW2.debug?
    puts "このとき、スライダーの値は[#{slider.value}]" if BW2.debug?
    reset_players_if_needed
    @interval_time = slider.value.round(2)
    shimo_player.play
    @kami_playing = false
  end

  def font_changed(notification)
    layout.font_changed(notification)
  end

  private

  def init_slider_value
    slider.value = initial_interval_time
    layout.update_interval_label
  end

  def initial_interval_time
    app_delegate.reciting_settings.interval_time || 1.00
  end

  def set_parts_actions
    layout.try_button.on(:touch){try_button_pushed}
    layout.slider.on(:value_changed){slider_value_changed}
  end

  def interval_count_down
    puts "- #{interval_time}秒間の間隔を開けます。" if BW2.debug?
    @last_time = interval_time

    NSLog '  - Timer Start!' if BW2.debug?
    NSTimer.scheduledTimerWithTimeInterval(SHORTEN_INTERVAL,
                                           target: self,
                                           selector: 'shorten_last_time:',
                                           userInfo: nil,
                                           repeats: true)
  end

  def set_kami_shimo_players
    supplier = PoemSupplier.new  # 間隔調節用に、全く新規のsupplierを作る
    supplier.draw_next_poem
    supplier.step_into_shimo
    # @shimo_player = supplier.player # 一首目の下の句を再生するプレーヤー
    @shimo_player = fetch_player_of(supplier)

    supplier.draw_next_poem
    # @kami_player = supplier.player  # 二首目の下の句を再生するプレーヤー
    @kami_player = fetch_player_of(supplier)
  end

  def fetch_player_of(supplier)
    AudioPlayerFactory.create_player_of(supplier.poem, side: supplier.side).tap {|p| p.delegate = self}
  end

  def reset_players_if_needed
    return unless self.kami_player.playing? or self.shimo_player.playing?
    reset_players
  end

  def reset_players
    reset_player self.kami_player
    reset_player self.shimo_player
  end

  # @param [AVAudioPlayer] player
  def reset_player(player)
    player.pause if player.playing?
    player.currentTime = 0.0
    player.prepareToPlay
  end
end

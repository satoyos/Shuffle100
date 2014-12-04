class VolumeSettingScreen < PM::Screen
  include OH::Notifications

  title '音量の調整'

  attr_reader :test_player, :layout

  def on_load
    set_test_player
    @layout = VolumeSettingLayout.new.build
    self.view = layout.view
    init_slider_value
    set_parts_actions
    set_font_changed_notification
  end

  def will_disappear
    puts ' - 音量を %1.2f秒に書き換えます！' % slider.value if BW2.debug?
    app_delegate.reciting_settings.volume = slider.value.round(2)
  end

  def should_autorotate
    false
  end

  def audioPlayerDidFinishPlaying(player, successfully:flag)
    return unless flag

    puts '- 読み上げが無事に終了！' if BW2.debug?
    reset_player
    play_button.enabled = true
  end

  def font_changed(notification)
    layout.font_changed(notification)
  end

  private

  def init_slider_value
    slider.value = app_delegate.reciting_settings.volume || 1.0
  end

  def set_parts_actions
    play_button.on(:touch){play_button_pushed2}
    slider.on(:value_changed){slider_value_changed2}
  end

  def play_button_pushed2
    puts 'テスト再生ボタン is pushed!' if BW2.debug?
    reset_player
    test_player.play
    play_button.enabled = false
  end

  def slider_value_changed2
    puts "- スライダーの値は #{slider.value}" if BW2.debug?
    test_player.volume = slider.value
  end

  def set_test_player
    supplier = PoemSupplier.new
    supplier.draw_next_poem
    @test_player = supplier.player.tap do |player|
      player.delegate = self
      player.volume = app_delegate.reciting_settings.volume
    end
  end

  def reset_player
    test_player.prepareToPlay
    play_button.enabled = true
  end

  def play_button
    @play_button || layout.get(:play_button)
  end

  def slider
    @slider || layout.get(:slider)
  end
end

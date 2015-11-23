class SpeedSettingScreen < PM::Screen
  title '読み上げスピード'

  attr_reader :kami_player, :layout, :slider, :rate_label

  def on_load
    set_kami_player
    @layout = SpeedSettingLayout.new.tap {|l|
      l.sizes = app_delegate.sizes ? app_delegate.sizes :
          OH::DeviceSizeManager.select_sizes # こっちはRSpecテスト用
    }
    self.view = layout.view
    @slider = layout.slider
    @rate_label = layout.rate_label
    init_slider_value
    set_parts_actions
  end

  def will_disappear
    puts ' - speed_rateの値を %1.1f秒に書き換えます！' % current_rate if BW2.debug?
    app_delegate.reciting_settings.speed_rate = current_rate
  end

  def slider_value_changed
    puts 'Sliderの値が変わったよ！' if BW2.debug?
    reset_player_if_needed
    layout.update_rate_label
  end

  def try_button_pushed
    puts "お試しボタン is pushed" if BW2.debug?
    puts "このとき、スライダーの値は[#{slider.value}]" if BW2.debug?
    reset_player_if_needed
    puts "player.rate => [#{kami_player.rate}]" if BW2.debug?
    kami_player.play
  end

  def should_autorotate
    false
  end

  private

  def set_kami_player
    supplier = PoemSupplier.new  # 全く新規のsupplierを作る
    supplier.draw_next_poem
    @kami_player = AudioPlayerFactory.create_player_of(supplier.poem, side: :kami)
    kami_player.delegate = self
  end

  def init_slider_value
    slider.value = initial_speed_rate
    layout.update_rate_label
  end

  def initial_speed_rate
    app_delegate.reciting_settings.speed_rate || 1.0
  end

  def set_parts_actions
    layout.try_button.on(:touch){try_button_pushed}
    layout.slider.on(:value_changed){slider_value_changed}
  end

  def reset_player_if_needed
    kami_player.pause if kami_player.playing?
    kami_player.currentTime = 0.0
    kami_player.rate = current_rate
    kami_player.prepareToPlay
  end

  def current_rate
    slider.value.round(1)
  end
end
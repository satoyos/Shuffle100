class KamiShimoIntervalSettingScreen < IntervalSettingScreen
  title '上の句と下の句の間隔'

  def will_disappear
    puts ' - 上下interval_timeの値を %1.2f秒に書き換えます！' % interval_slider.value if BW2.debug?
    app_delegate.reciting_settings.kami_shimo_interval = interval_slider.value.round(2)
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

end
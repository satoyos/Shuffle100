class KamiShimoIntervalSettingScreen < IntervalSettingScreen
  title '上の句と下の句の間隔'

  private

  def set_kami_shimo_players
    supplier = PoemSupplier.new  # 間隔調節用に、全く新規のsupplierを作る
    supplier.draw_next_poem
    @kami_player = supplier.player.tap {|p| p.delegate = self}
    supplier.step_into_shimo
    @shimo_player = supplier.player.tap {|p| p.delegate = self}
  end

end
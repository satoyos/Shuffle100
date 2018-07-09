class FudaSetsScreen < PM::TableScreen
  title '作った札セット'

  def on_load
    @fuda_sets = app_delegate.game_settings.fuda_sets
  end

  def table_data
    [{
        cells: @fuda_sets.map do |set|
          {
              title: set.name
          }
        end
     }]
  end

end
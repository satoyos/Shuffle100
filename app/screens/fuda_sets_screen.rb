class FudaSetsScreen < PM::TableScreen
  title '作った札セット'

  def on_load
    @fuda_sets = app_delegate.game_settings.fuda_sets
  end

  def table_data
    [{
        cells: @fuda_sets.map do |set|
          {
              title: set.name,
              editing_style: :delete, # (can be :delete, :insert, or :none),
              cell_style: UITableViewCellStyleValue1,
              subtitle: '%d首' % set.status100.selected_num,
          }
        end
     }]
  end

  def on_cell_deleted(cell, index_path)
    app_delegate.game_settings.fuda_sets.delete_at(index_path.row)
    app_delegate.settings_manager.save
  end

end
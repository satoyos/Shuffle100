class OnGameSettingsScreen < PM::TableScreen
  title 'いろいろな設定'

  def on_load
    set_nav_bar_button :right, title: '設定終了', action: :done_button_did_pushed
  end

  def will_appear
    update_table_data
    set_attributes self.view, {
        background_color: hex_color('FFFFFF')
    }
  end

  def table_data
    [{
        cells: [{
                    title: '歌と歌の間隔',
                    cell_style: UITableViewCellStyleValue1,
                    subtitle: '%1.2f秒' % app_delegate.reciting_settings.interval_time,
                    action: :tapped_interval_cell,
                    accessoryType: UITableViewCellAccessoryDisclosureIndicator,
                }]
     }]
  end

  def tapped_interval_cell
    puts ' - IntervalCell is tapped!' if BW::debug?
    open IntervalSettingScreen.new, nav_bar: true
  end

  def done_button_did_pushed
    puts 'Done button pushed.' if BW::debug?
    app_delegate.settings_manager.save
    close
  end

end

class OnGameSettingsScreen < PM::TableScreen
  ACC_LABEL_INTERVAL_CELL = 'interval'

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

  def should_autorotate
    false
  end

  def table_data
    [{
        cells: on_game_setting_cells
     }]
  end

  def tapped_interval_cell
    puts ' - IntervalCell is tapped!' if BW2.debug?
    open IntervalSettingScreen.new, nav_bar: true
  end

  def tapped_kami_shimo_interval_cell
    puts ' - 上下IntervalCell is tapped!' if BW2.debug?
    open KamiShimoIntervalSettingScreen.new, nav_bar: true
  end

  def tapped_speed_cell
    puts ' - SpeedCell is tapped!' if BW2.debug?
    open SpeedSettingScreen.new, nav_bar: true
  end

  def tapped_volume_cell
    puts ' - VolumeCell is tapped!' if BW2.debug?
    open VolumeSettingScreen.new, nav_bar: true
  end

  def done_button_did_pushed
    puts 'Done button pushed.' if BW2.debug?
    app_delegate.settings_manager.save
    close
  end

  private

  def on_game_setting_cells
    cells = [
        poems_interval_cell,
        speed_setting_cell,
        volume_setting_cell
    ]
    return cells unless app_delegate.game_settings.beginner_flg
    cells.insert(1, kami_shimo_interval_cell)
  end

  def poems_interval_cell
    {
        title: '歌と歌の間隔',
        cell_style: UITableViewCellStyleValue1,
        subtitle: '%1.2f秒' % app_delegate.reciting_settings.interval_time,
        action: :tapped_interval_cell,
        style: {
            accessoryType: UITableViewCellAccessoryDisclosureIndicator,
            # accessibilityLabel: ACC_LABEL_INTERVAL_CELL
        }
    }
  end

  def kami_shimo_interval_cell
    {
        title: '上の句と下の句の間隔',
        cell_style: UITableViewCellStyleValue1,
        subtitle: '%1.2f秒' % app_delegate.reciting_settings.kami_shimo_interval,
        action: :tapped_kami_shimo_interval_cell,
        style: {
            accessoryType: UITableViewCellAccessoryDisclosureIndicator,
        }

    }
  end

  def volume_setting_cell
    {
        title: '音量調整',
        action: :tapped_volume_cell,
        style: {
            accessoryType: UITableViewCellAccessoryDisclosureIndicator,
        }
    }
  end

  def speed_setting_cell
    {
        title: '読み上げスピード',
        cell_style: UITableViewCellStyleValue1,
        action: :tapped_speed_cell,
        subtitle: '%1.1f倍速' % app_delegate.reciting_settings.speed_rate,
        style: {
            accessoryType: UITableViewCellAccessoryDisclosureIndicator,
        }
    }
  end

end

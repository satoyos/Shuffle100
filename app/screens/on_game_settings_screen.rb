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
                    cell_class: IntervalSettingCell,
                    action: :tapped_interval_cell,
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

class IntervalSettingCell < ProMotion::TableViewCell
  def setup(data_cell, screen)
    super
    label = UILabel.alloc.initWithFrame(CGRectZero).tap do |l|
      l.text = '%1.2f秒' % screen.app_delegate.reciting_settings.interval_time
      l.sizeToFit
      l.frame =
          [
              [
                  self.frame.size.width - l.frame.size.width - 30,
                  (self.frame.size.height - l.frame.size.height)/2
              ],
              l.frame.size
          ]
    end
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator
    data_cell[:subviews] = [label]
    set_subviews

    self
  end
end
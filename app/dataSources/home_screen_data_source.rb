module HomeScreenDataSource
  FAKE_SETTING_TITLE = '空札を加える'

  def table_data
    [
        {
            title: '設定',
            title_view_height: 30,
            cells: game_setting_cells
        },
        {
            title: '試合開始',
            cells: [start_game_cell]
        }
    ]
  end

  def game_setting_cells
    cells = [
        select_poems_cell,
        beginner_mode_switch_cell,
    ]
    cells << fake_mode_switch_cell unless app_delegate.game_settings.beginner_flg
    cells
  end

  def select_poems_cell
    {
        title: HomeScreen::SELECT_POEM_TITLE,
        cell_style: UITableViewCellStyleValue1,
        subtitle: '%d首' % loaded_selected_status.selected_num,
        action: :select_poems,
        accessoryType: UITableViewCellAccessoryDisclosureIndicator,
        accessibilityLabel: 'select_poem',
    }
  end

  def beginner_mode_switch_cell
    {
        title: '初心者モード(散らし取り)',
        accessory: {
            view: :switch,
            value: app_delegate.game_settings.beginner_flg,
            action: 'beginner_switch_flipped:',
            accessibilityLabel: 'beginner_switch'
        }
    }
  end

  def fake_mode_switch_cell
    {
        title: FAKE_SETTING_TITLE,
        accessory: {
            view: :switch,
            value: app_delegate.game_settings.fake_flg,
            action: 'fake_switch_flipped:',
            accessibilityLabel: 'fake_switch'
        }
    }
  end

  def start_game_cell
    {
        title: '試合開始',
        action: :start_game,
        cell_class: GameStartCell,
    }
  end
end
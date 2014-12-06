module HomeScreenDataSource
  FAKE_SETTING_TITLE = '空札を加える'
  GAME_START_STR = '試合開始'

  def table_data
    [
        {
            title: '設定',
            title_view_height: 30,
            cells: game_setting_cells
        },
        {
            title: GAME_START_STR,
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
        cell_identifier: 'select_poem',
        style: {
            accessoryType: UITableViewCellAccessoryDisclosureIndicator,
        }
    }
  end

  def beginner_mode_switch_cell
    {
        title: '初心者モード(散らし取り)',
        cell_identifier: 'beginner_switch',
        accessory: {
            view: :switch,
            value: app_delegate.game_settings.beginner_flg,
            action: 'beginner_switch_flipped:',
            arguments: {}
        }
    }
  end

  def fake_mode_switch_cell
    {
        title: FAKE_SETTING_TITLE,
        cell_identifier: 'fake_switch',
        accessory: {
            view: :switch,
            value: app_delegate.game_settings.fake_flg,
            action: 'fake_switch_flipped:',
            arguments: {}
        }
    }
  end

  def start_game_cell
    {
        title: GAME_START_STR,
        action: :start_game,
        cell_class: GameStartCell,
    }
  end
end
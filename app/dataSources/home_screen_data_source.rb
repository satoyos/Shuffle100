module HomeScreenDataSource
  FAKE_SETTING_TITLE = '空札を加える'
  GAME_START_STR = '試合開始'

  def table_data
    [
        {
            title: '設定',
            title_view_height: 40,
            cells: game_setting_cells
        },
        {
            title: GAME_START_STR,
            cells: [start_game_cell]
        }
    ]
  end

  private

  def game_setting_cells
    cells = [
        select_poems_cell,
        recite_mode_cell,
    ]
    cells << fake_mode_switch_cell unless app_delegate.game_settings.beginner_flg
    cells << select_singer_cell
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

  def recite_mode_cell
    {
        title: '読み上げモード',
        cell_identifier: 'recite_mode',
        cell_style: UITableViewCellStyleValue1,
        subtitle: ReciteMode.get_recite_mode_of_id(app_delegate.game_settings.recite_mode_id).name,
        style: {
            accessoryType: UITableViewCellAccessoryDisclosureIndicator,
        },
        action: :select_recite_mode
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

  def select_singer_cell
    {
        title: '読手',
        cell_identifier: 'select_singer',
        cell_style: UITableViewCellStyleValue1,
        subtitle: saved_singers_name,
        action: :select_singer,
        style: {
            accessoryType: UITableViewCellAccessoryDisclosureIndicator,
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

  private

  def saved_singers_name
    saved_index = app_delegate.game_settings.singer_index
    Singer.singers[saved_index].name
  end
end
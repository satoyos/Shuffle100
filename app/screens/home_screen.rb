class HomeScreen < PM::GroupedTableScreen
  include SelectedStatusHandler
  title 'トップ'

  def table_data
    [
        {
            title: "設定",
            title_view_height: 30,
            cells: [
                {
                    title: '取り札を用意する歌',
                    cell_style: UITableViewCellStyleValue1,
                    subtitle: '%d首' % loaded_selected_status.selected_num,
                    action: :select_poems,
                    accessoryType: UITableViewCellAccessoryDisclosureIndicator,
                },
                {
                    title: 'title2'
                },
                {
                    title: 'title3'
                }
            ]
        },
        {
            title: '試合開始',
            cells: [{title: '試合開始',
                     action: :start_game,
                     cell_class: GameStartCell,
                    }]
        }
    ]
  end

  def will_appear
    puts 'home - will_appear' if BW::debug?
    navigation_controller.setNavigationBarHidden(false, animated: false) if self.nav_bar?
    self.navigationItem.prompt = '百首読み上げ'
    update_table_data
  end

  def will_present
    puts 'home - will_present' if BW::debug?
  end

  def should_autorotate
    false
  end

  def start_game
    puts '++ 試合開始！' if BW::debug?
    navigation_controller.setNavigationBarHidden(true, animated: true)
    open RecitePoemScreen.new
  end

  def select_poems
    puts ' - 歌を選ぶ画面へ！' if BW::debug?
    open PoemPicker.new
  end
end
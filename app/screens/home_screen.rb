class HomeScreen < PM::GroupedTableScreen
  include SelectedStatusHandler
  title 'トップ'

  SELECT_POEM_TITLE = '取り札を用意する歌'
  FAKE_SETTING_TITLE = '空札を加える'

  def table_data
    [
        {
            title: "設定",
            title_view_height: 30,
            cells: [
                {
                    title: SELECT_POEM_TITLE,
                    cell_style: UITableViewCellStyleValue1,
                    subtitle: '%d首' % loaded_selected_status.selected_num,
                    action: :select_poems,
                    accessoryType: UITableViewCellAccessoryDisclosureIndicator,
                    accessibilityLabel: 'select_poem',
                },
                {
                    title: FAKE_SETTING_TITLE,
                    accessory: {
                        view: :switch,
                        action: :foo,
                        accessibilityLabel: 'fake_switch'
                    }
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
    if loaded_selected_status.selected_num == 0
      alert_no_poem_selected()
      return
    end
    puts '++ 試合開始！' if BW::debug?
    navigation_controller.setNavigationBarHidden(true, animated: true)
    app_delegate.poem_supplier = PoemSupplier.new({deck: selected_poems_deck})
    open RecitePoemScreen.new
  end

  def select_poems
    puts ' - 歌を選ぶ画面へ！' if BW::debug?
    open PoemPicker.new
  end

  private

  def selected_poems_deck
    Deck.create_from_bool100(loaded_selected_status.status_array).shuffle
  end

  def alert_no_poem_selected
    UIAlertView.alloc.init.tap{|alert_view|
      alert_view.title ='歌を選びましょう'
      alert_view.message = "「#{SELECT_POEM_TITLE}」で、試合に使う歌を選んでください。"
      alert_view.addButtonWithTitle('戻る')
    }.show
  end

end

class UISwitch
  def set_on
    puts 'スイッチをonにします！'
    self.on = true
  end
end


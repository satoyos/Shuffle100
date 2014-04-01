class HomeScreen < PM::GroupedTableScreen
  include SelectedStatusHandler
  title 'トップ'

  SELECT_POEM_TITLE = '取り札を用意する歌'
  FAKE_SETTING_TITLE = '空札を加える'

  INFO_BUTTON_SIZE = CGSizeMake(16, 16)
  ACC_LABEL_INFO_BUTTON = 'Info'

  def table_data
    [
        {
            title: '設定',
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
                        value: app_delegate.game_settings.fake_flg,
                        action: 'fake_switch_flipped:',
                        accessibilityLabel: 'fake_switch'
                    }
                },
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

  def on_load
    set_nav_bar_button :right, {
        image: info_image,
        action: :open_info
    }
  end

  def will_appear
    puts 'home - will_appear' if BW::debug?
    navigation_controller.setNavigationBarHidden(false, animated: false) if self.nav_bar?
    self.navigationItem.prompt = '百首読み上げ'
    update_table_data
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
    new_deck = app_delegate.game_settings.fake_flg ?
        selected_poems_deck.add_fake_poems! :
        selected_poems_deck

    app_delegate.poem_supplier = PoemSupplier.new({deck: new_deck})
    open RecitePoemScreen.new
  end

  def select_poems
    puts ' - 歌を選ぶ画面へ！' if BW::debug?
    open PoemPicker.new
  end

  def fake_switch_flipped(data_hash)
    # ap data_hash if BW::debug?
    app_delegate.game_settings.fake_flg = data_hash[:value]
    app_delegate.settings_manager.save
  end

  def open_info
    puts '- Info Button pushed!' if BW::debug?
    open InfoScreen.new
  end

  def info_image
    ResizeUIImage.resizeImage(UIImage.imageNamed('info_white.png'),
                              newSize: INFO_BUTTON_SIZE)
  end

  private

  # @return [Deck] 選択された歌から構成されるDeck。歌の順序はShuffleされている。
  def selected_poems_deck
    Deck.create_from_bool100(loaded_selected_status.status_array).shuffle!
  end

  def alert_no_poem_selected
    UIAlertView.alloc.init.tap{|alert_view|
      alert_view.title ='歌を選びましょう'
      alert_view.message = "「#{SELECT_POEM_TITLE}」で、試合に使う歌を選んでください。"
      alert_view.addButtonWithTitle('戻る')
    }.show
  end

=begin
  def info_button
    UIButton.buttonWithType(UIButtonTypeRoundedRect).tap do |b|
      # b.contentEdgeInsets = button_insets
      b.setImage(info_image, forState: UIControlStateNormal)
      # b.frame = [[0, PROMPT_HEIGHT], button_size]
      b.addTarget(self,
                  action: 'open_info',
                  forControlEvents: UIControlEventTouchUpInside)
      b.accessibilityLabel = ACC_LABEL_INFO_BUTTON
    end
  end
=end


end

class UISwitch
#  weak_attr delegate

  def set_on
    puts 'スイッチをonにします！' if BW::debug?
    self.on = true
  end
  def set_off
    puts 'スイッチをoffにします！' if BW::debug?
    self.on = false
  end
end


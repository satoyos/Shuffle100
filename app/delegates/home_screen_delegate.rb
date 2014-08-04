module HomeScreenDelegate
  SELECT_POEM_TITLE = '取り札を用意する歌'

  def select_poems
    puts ' - 歌を選ぶ画面へ！' if BW::debug?
    open PoemPicker.new
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

  def fake_switch_flipped(data_hash)
    # ap data_hash if BW::debug?
    app_delegate.game_settings.fake_flg = data_hash[:value]
    app_delegate.settings_manager.save
  end

  def beginner_switch_flipped(data_hash)
    puts "初心者モードのスイッチが切り替わりました。(=> #{data_hash[:value]})" if BW::debug?
    app_delegate.game_settings.beginner_flg = data_hash[:value]
    app_delegate.settings_manager.save
    update_table_view_data_animated
  end

  def open_info
    puts '- Info Button pushed!' if BW::debug?
    open InfoMenuScreen.new
  end

  private

  def update_table_view_data_animated
    self.promotion_table_data.data = self.table_data
    table_view.reloadSections(NSIndexSet.indexSetWithIndex(0),
                              withRowAnimation: UITableViewRowAnimationFade)
  end

  def alert_no_poem_selected
    UIAlertView.alloc.init.tap{|alert_view|
      alert_view.title ='歌を選びましょう'
      alert_view.message = "「#{SELECT_POEM_TITLE}」で、試合に使う歌を選んでください。"
      alert_view.addButtonWithTitle('戻る')
    }.show
  end

  def beg_button_pushed
    puts 'beg_button_pushed!' if BW::debug?
    @beg_switch.setOn(true, animated: true)
    beginner_switch_flipped({value: true})
  end

  def beg_off_button_pushed
    puts 'beg_off_button_pushed!' if BW::debug?
    @beg_switch.setOn(false, animated: true)
    beginner_switch_flipped({value: false})
  end

end
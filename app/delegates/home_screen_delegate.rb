module HomeScreenDelegate

  def select_poems
    puts ' - 歌を選ぶ画面へ！' if BW2.debug?
    open PoemPicker.new
  end

  def select_singer
    puts ' - 読手を選ぶ画面へ！' if BW2.debug?
    open SelectSingerScreen.new
  end

  def start_game
    if loaded_selected_status.selected_num == 0
      alert_no_poem_selected()
      return
    end
    puts '++ 試合開始！' if BW2.debug?
    navigation_controller.setNavigationBarHidden(true, animated: true)
    new_deck = app_delegate.game_settings.fake_flg ?
        selected_poems_deck.add_fake_poems! :
        selected_poems_deck
    app_delegate.set_opening_player
    app_delegate.poem_supplier = PoemSupplier.new({deck: new_deck})
    if app_delegate.game_settings.beginner_flg
      open BeginnerReciteScreen.new
    else
      open RecitePoemScreen.new
    end
  end

  def fake_switch_flipped(data_hash)
    # ap data_hash if BW2.debug?
    app_delegate.game_settings.fake_flg = data_hash[:value]
    app_delegate.settings_manager.save
  end

  def beginner_switch_flipped(data_hash)
    puts "初心者モードのスイッチが切り替わりました。(=> #{data_hash[:value]})" if BW2.debug?
    app_delegate.game_settings.beginner_flg = data_hash[:value]
    app_delegate.game_settings.fake_flg = false if data_hash[:value]
    app_delegate.settings_manager.save
    update_table_view_data_animated
  end

  def open_help
    puts '- Help Button pushed!' if BW2.debug?
    open HelpMenuScreen.new
  end

  def open_on_game_settings
    puts 'ホーム画面から「いろいろな設定」画面を開くよ！' if BW2.debug?
    open OnGameSettingsScreen.new, modal: true, nav_bar: true
  end

  private

  # @return [Deck] 選択された歌から構成されるDeck。歌の順序はShuffleされている。
  def selected_poems_deck
    Deck.create_from_bool100(loaded_selected_status.status_array).shuffle!
  end

  def update_table_view_data_animated
    self.promotion_table_data.data = self.table_data
    table_view.reloadSections(NSIndexSet.indexSetWithIndex(0),
                              withRowAnimation: UITableViewRowAnimationFade)
  end

  def alert_no_poem_selected
    UIAlertView.alloc.init.tap{|alert_view|
      alert_view.title ='歌を選びましょう'
      alert_view.message = "「#{HomeScreen::SELECT_POEM_TITLE}」で、試合に使う歌を選んでください。"
      alert_view.addButtonWithTitle('戻る')
    }.show
  end
end
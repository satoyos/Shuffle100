module HomeScreenDelegate

  def select_poems
    puts ' - 歌を選ぶ画面へ！' if BW2.debug?
    open PoemPicker.new
  end

  def select_singer
    puts ' - 読手を選ぶ画面へ！' if BW2.debug?
    open SelectSingerScreen.new
  end

  def select_recite_mode
    puts ' - 読み上げモードを選ぶ画面へ！' if BW2.debug?
    open ModeSelectScreen.new
  end

  def start_game
    if loaded_selected_status.selected_num == 0
      alert_no_poem_selected()
      return
    end
    puts '++ 試合開始！' if BW2.debug?
    prohibit_sleeping
    navigation_controller.setNavigationBarHidden(true, animated: true)
    app_delegate.prepare_game
    open_recite_screen_of(app_delegate.game_settings.recite_mode_id)
  end

  def fake_switch_flipped(data_hash)
    # ap data_hash if BW2.debug?
    app_delegate.game_settings.fake_flg = data_hash[:value]
    app_delegate.settings_manager.save
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

  def update_table_view_data_animated
    self.promotion_table_data.data = self.table_data
    table_view.reloadSections(NSIndexSet.indexSetWithIndex(0),
                              withRowAnimation: UITableViewRowAnimationFade)
  end

  def alert_no_poem_selected
    UIAlertView.alloc.init.tap{|alert_view|
      alert_view.title ='歌を選びましょう'
      alert_view.message = "「#{HomeScreenDataSource::SELECT_POEM_TITLE}」で、試合に使う歌を選んでください。"
      alert_view.addButtonWithTitle('戻る')
    }.show
  end

  private

  def mode_from_beginner_flg(flg)
    return :beginner if flg
    return :normal
  end

  def open_recite_screen_of(mode)
    case mode
      when :normal   ; open RecitePoemScreen.new
      when :beginner ; open BeginnerReciteScreen.new
      # when :nonstop  ; puts 'ノンストップ・モードの実装はまだです！'
      when :nonstop  ; open NonstopReciteScreen.new
      else ; raise("読み上げモード[#{mode}]はサポートしていません！")
    end
  end
end
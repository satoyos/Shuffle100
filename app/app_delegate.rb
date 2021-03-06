class AppDelegate < PM::Delegate
  include PM::Styling

  BAR_TINT_COLOR = '#cee4ae'.uicolor #夏虫色
  BUTTON_NORMAL_COLOR = '#007bbbjjj'.uicolor # 紺碧
  PROMPT = '百首読み上げ'

  attr_accessor :poem_supplier, :players_hash, :opening_player
  attr_accessor :settings_manager, :reciting_settings, :game_settings
  attr_reader :sizes, :prompt

  def on_load(app, options)
    BW2.debug = true unless 'AppStoreRelease'.info_plist
    set_models
    set_appearance_defaults
    open HomeScreen.new(nav_bar: true)
  end

  def set_models
    # AudioPlayerFactory.prepare_audio_players({opening: 'audio/ia/序歌'})
    self.poem_supplier = PoemSupplier.new({size: 50, shuffle: true, limit: 3}) # データができているのは10番まで
    self.settings_manager = SettingsManager.new
    self.reciting_settings = settings_manager.reciting_settings
    self.game_settings     = settings_manager.game_settings
    set_opening_player
    @prompt = PROMPT
  end

  def prepare_game
    new_deck = game_settings.fake_flg ?
                   selected_poems_deck.add_fake_poems! :
                   selected_poems_deck
    set_opening_player
    self.poem_supplier = PoemSupplier.new({deck: new_deck})
  end

  def set_opening_player
    AudioPlayerFactory.prepare_audio_players({opening: current_singer_folder + '/序歌'})
    self.opening_player = AudioPlayerFactory.players[:opening]
  end

  def current_status100
    self.game_settings.statuses_for_deck.first
  end

  def current_status100=(status100)
    raise '正しいstatus100を指定してください。' unless status100.is_a?(SelectedStatus100)
    self.game_settings.statuses_for_deck = [status100]
  end

  def current_singer_folder
    Singer.singers[game_settings.singer_index].path
  end

  def set_delegate_screen(s)
    @delegate = s
  end

  def on_enter_background
    puts 'xxx アプリがバックグラウンドに入っちゃった！(AppDelegateで検出）' if BW2.debug?
    @delegate.did_enter_background if @delegate
  end

  def on_activate
    puts 'ooo アプリがフォアグラウンドなう！！(AppDelegateで検出）' if BW2.debug?
    @delegate.did_become_active if @delegate
  end

  private

  def set_appearance_defaults
    UINavigationBar.appearance.barTintColor = BAR_TINT_COLOR
    UIApplication.sharedApplication.statusBarOrientation = UIInterfaceOrientationPortrait
    @sizes = OH::DeviceSizeManager.select_sizes
  end

  # @return [Deck] 選択された歌から構成されるDeck。歌の順序はShuffleされている。
  def selected_poems_deck
    Deck.create_from_bool100(current_status100.status_array).shuffle!
  end
end

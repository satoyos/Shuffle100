#class AppDelegate
class AppDelegate < PM::Delegate
  include PM::Styling

  BAR_TINT_COLOR = '#cee4ae'.to_color #夏虫色
  PROMPT = '百首読み上げ'

  attr_accessor :poem_supplier, :players_hash, :opening_player
  attr_accessor :settings_manager, :reciting_settings, :game_settings

  def on_load(app, options)
    BW.debug = true unless App.info_plist['AppStoreRelease']

    set_models

    set_appearance_defaults

    open HomeScreen.new(nav_bar: true)
  end

  def set_models
    AudioPlayerFactory.prepare_audio_players({opening: 'audio/序歌'})
    self.opening_player = AudioPlayerFactory.players[:opening]
    self.poem_supplier = PoemSupplier.new({size: 50, shuffle: true, limit: 3}) # データができているのは10番まで
    self.settings_manager = SettingsManager.new
    self.reciting_settings = settings_manager.reciting_settings
    self.game_settings     = settings_manager.game_settings
  end

  def refresh_models
    set_models
  end

  def current_status100
    self.game_settings.statuses_for_deck.first
  end

  def current_status100=(status100)
    raise '正しいstatus100を指定してください。' unless status100.is_a?(SelectedStatus100)
    self.game_settings.statuses_for_deck = [status100]
  end

  def set_appearance_defaults
    UINavigationBar.appearance.barTintColor = BAR_TINT_COLOR
  end

  def load_rest_poems_sound
    AudioPlayerFactory.prepare_audio_players(m4a_files_hash)
  end


  def setting_players_of_poem(range)
    NSLog "start (#{range.to_a.size})"
    hash = {}
    range.each do |number|
      number_str_a = '%03da' % number
      number_str_b = '%03db' % number
      hash[number_str_a] = "audio/#{number_str_a}"
      hash[number_str_b] = "audio/#{number_str_b}"
    end
    AudioPlayerFactory.prepare_audio_players(hash)
    NSLog "end (#{range.to_a.size}"
  end

  def m4a_files_hash
#    hash = {opening: 'audio/序歌'}
    hash = {}
    (1..100).each do |number|
      number_str_a = '%03da' % number
      number_str_b = '%03db' % number
      hash[number_str_a] = "audio/#{number_str_a}"
      hash[number_str_b] = "audio/#{number_str_b}"
    end

    hash
  end
end

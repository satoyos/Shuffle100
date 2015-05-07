class SettingsManager
  KEY_RECITING_SETTINGS = 'reciting_settings'
  KEY_GAME_SETTINGS     = 'game_settings'

  attr_accessor :reciting_settings, :game_settings

  def initialize
    self.load
  end

  def load
    puts '* 設定データを読み込みます' if BW2.debug?
    rs_data = standard_defaults.objectForKey(KEY_RECITING_SETTINGS)
    puts " - rs_datra => #{rs_data}" if BW2.debug?
    self.reciting_settings = unarchived_rs_data(rs_data) || RecitingSettings.new
    gs_data = game_settings_defaults.objectForKey(KEY_GAME_SETTINGS)
    puts " - gs_datra => #{gs_data}" if BW2.debug?
    self.game_settings = unarchived_gs_data(gs_data) || GameSettings.new
    return unless BW2.debug?
    puts 'unarchived(rs_data)=>'
    ap unarchived_rs_data(rs_data)
    puts 'unarchived(gs_data)=>'
    ap unarchived_gs_data(gs_data)
    puts '*設定データの読み込み終了'
  end

  def save
    puts '* 設定データを永続化します' if BW2.debug?
    rs_data = rs_data_to_save
    standard_defaults.setObject(rs_data, forKey: KEY_RECITING_SETTINGS)
    puts " - rs_datra => #{rs_data}" if BW2.debug?
    standard_defaults.synchronize
    puts ' - standard_defaultsに永続化しました。' if BW2.debug?
    gs_data = gs_data_to_save
    puts " - gs_datra => #{gs_data}" if BW2.debug?
    game_settings_defaults.setObject(gs_data, forKey: KEY_GAME_SETTINGS)
    game_settings_defaults.synchronize
    puts ' - game_settings_defaultsに永続化しました。' if BW2.debug?
  end

  def standard_defaults
    NSUserDefaults.standardUserDefaults
  end

  def game_settings_defaults
    @game_settings_defaults ||= NSUserDefaults.alloc.initWithSuiteName(KEY_GAME_SETTINGS)
  end

  def rs_data_to_save
    NSKeyedArchiver.archivedDataWithRootObject(reciting_settings)
  end

  def gs_data_to_save
    NSKeyedArchiver.archivedDataWithRootObject(game_settings)
  end

  def unarchived_rs_data(rs_data)
    NSKeyedUnarchiver.unarchiveObjectWithData(rs_data)
  end

  def unarchived_gs_data(gs_data)
    NSKeyedUnarchiver.unarchiveObjectWithData(gs_data)
  end
end
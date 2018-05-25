class SettingsManager
  KEY_RECITING_SETTINGS = 'reciting_settings'
  KEY_GAME_SETTINGS     = 'game_settings'
  KEY_FUDA_SETS         = 'fuda_sets'

  attr_reader :reciting_settings, :game_settings

  def initialize
    self.load
  end

  def load
    puts '* 設定データを読み込みます' if BW2.debug?
    rs_data = standard_defaults.objectForKey(KEY_RECITING_SETTINGS)
    @reciting_settings = unarchived_rs_data(rs_data) || RecitingSettings.new
    gs_data = game_settings_defaults.objectForKey(KEY_GAME_SETTINGS)
    @game_settings = unarchived_gs_data(gs_data) || GameSettings.new
  end

  def save
    puts '* 設定データを永続化します' if BW2.debug?
    rs_data = rs_data_to_save
    standard_defaults.setObject(rs_data, forKey: KEY_RECITING_SETTINGS)
    standard_defaults.synchronize
    gs_data = gs_data_to_save
    game_settings_defaults.setObject(gs_data, forKey: KEY_GAME_SETTINGS)
    game_settings_defaults.synchronize
  end

  def standard_defaults
    NSUserDefaults.standardUserDefaults
  end

  def game_settings_defaults
    @game_settings_defaults ||= NSUserDefaults.alloc.initWithSuiteName(KEY_GAME_SETTINGS)
  end

  def fuda_sets_defaults
    @fuda_sets_defaults ||= NSUserDefaults.alloc.initWithSuiteName(KEY_FUDA_SETS)
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
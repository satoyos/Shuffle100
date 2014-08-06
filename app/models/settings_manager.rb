class SettingsManager
  KEY_RECITING_SETTINGS = 'reciting_settings'
  KEY_GAME_SETTINGS     = 'game_settings'

  attr_accessor :reciting_settings, :game_settings

  def initialize
    self.load
  end

  def load
    puts '* 設定データを読み込みます' if BW2.debug?
    rs_data = NSUserDefaults.standardUserDefaults.objectForKey(KEY_RECITING_SETTINGS)
    self.reciting_settings =
        NSKeyedUnarchiver.unarchiveObjectWithData(rs_data) || RecitingSettings.new
    gs_data = NSUserDefaults.standardUserDefaults.objectForKey(KEY_GAME_SETTINGS)
    self.game_settings =
        NSKeyedUnarchiver.unarchiveObjectWithData(gs_data) || GameSettings.new
  end

  def save
    puts '* 設定データを永続化します' if BW2.debug?
    rs_data = NSKeyedArchiver.archivedDataWithRootObject(self.reciting_settings)
    NSUserDefaults.standardUserDefaults.setObject(rs_data, forKey: KEY_RECITING_SETTINGS)
    gs_data = NSKeyedArchiver.archivedDataWithRootObject(self.game_settings)
    NSUserDefaults.standardUserDefaults.setObject(gs_data, forKey: KEY_GAME_SETTINGS)
    NSUserDefaults.standardUserDefaults.synchronize
  end

end
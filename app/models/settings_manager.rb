class SettingsManager
  KEY_RECITING_SETTINGS = 'reciting_settings'

  attr_accessor :reciting_settings

  def initialize
    self.load
  end

  def load
    data = NSUserDefaults.standardUserDefaults.objectForKey(KEY_RECITING_SETTINGS)
    self.reciting_settings =
        NSKeyedUnarchiver.unarchiveObjectWithData(data) || RecitingSettings.new
  end

  def save
    data = NSKeyedArchiver.archivedDataWithRootObject(self.reciting_settings)
    NSUserDefaults.standardUserDefaults.setObject(data, forKey: KEY_RECITING_SETTINGS)
    NSUserDefaults.standardUserDefaults.synchronize
  end

end
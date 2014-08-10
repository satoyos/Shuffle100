class GameSettings
  KEY_STATUSES = 'statuses_for_deck'
  KEY_FAKE_FLG = 'fake_flg'
  KEY_BEGINNER_FLG = 'beginner_flg'
  KEY_KAMI_SHIMO_INTERVAL = 'kami_shimo_interval'
  DEFAULT_KAMI_SHIMO_INTERVAL_TIME = 1.5

  attr_accessor :statuses_for_deck, :fake_flg
  attr_accessor :kami_shimo_interval, :beginner_flg

  def initialize
    self.statuses_for_deck = initial_statuses
    self.fake_flg = false
    self.beginner_flg = false
    self.kami_shimo_interval = DEFAULT_KAMI_SHIMO_INTERVAL_TIME
  end

  # @param [NSCoder] decoder
  def initWithCoder(decoder)
    self.statuses_for_deck = decoder.decodeObjectForKey(KEY_STATUSES) || initial_statuses
    self.fake_flg = decoder.decodeBoolForKey(KEY_FAKE_FLG) || false
    self.beginner_flg = decoder.decodeBoolForKey(KEY_BEGINNER_FLG) || false
    self.kami_shimo_interval =
        decoder.decodeObjectForKey(KEY_KAMI_SHIMO_INTERVAL) || DEFAULT_KAMI_SHIMO_INTERVAL_TIME
    self
  end

  # @param [NSCoder] encoder
  def encodeWithCoder(encoder)
    encoder.encodeObject(self.statuses_for_deck, forKey: KEY_STATUSES)
    encoder.encodeBool(self.fake_flg, forKey: KEY_FAKE_FLG)
    encoder.encodeBool(self.beginner_flg, forKey: KEY_BEGINNER_FLG)
    encoder.encodeObject(self.kami_shimo_interval, forKey: KEY_KAMI_SHIMO_INTERVAL)
  end

  def initial_statuses
    [
        SelectedStatus100.new(true)
    ]
  end
end
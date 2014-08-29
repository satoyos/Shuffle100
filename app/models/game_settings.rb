class GameSettings
  KEY_STATUSES = 'statuses_for_deck'
  KEY_FAKE_FLG = 'fake_flg'
  KEY_BEGINNER_FLG = 'beginner_flg'

  attr_accessor :statuses_for_deck, :fake_flg
  attr_accessor :beginner_flg

  def initialize
    self.statuses_for_deck = initial_statuses
    self.fake_flg = false
    self.beginner_flg = false
  end

  # @param [NSCoder] decoder
  def initWithCoder(decoder)
    self.statuses_for_deck = decoder.decodeObjectForKey(KEY_STATUSES) || initial_statuses
    self.fake_flg = decoder.decodeBoolForKey(KEY_FAKE_FLG) || false
    self.beginner_flg = decoder.decodeBoolForKey(KEY_BEGINNER_FLG) || false
    self
  end

  # @param [NSCoder] encoder
  def encodeWithCoder(encoder)
    encoder.encodeObject(self.statuses_for_deck, forKey: KEY_STATUSES)
    encoder.encodeBool(self.fake_flg, forKey: KEY_FAKE_FLG)
    encoder.encodeBool(self.beginner_flg, forKey: KEY_BEGINNER_FLG)
  end

  def initial_statuses
    [
        SelectedStatus100.new(true)
    ]
  end
end
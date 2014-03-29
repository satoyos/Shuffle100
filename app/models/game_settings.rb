class GameSettings
  KEY_STATUSES = 'statuses_for_deck'
  KEY_FAKE_FLG = 'fake_flg'

  attr_accessor :statuses_for_deck, :fake_flg

  def initialize
    self.statuses_for_deck = initial_statuses
  end

  # @param [NSCoder] decoder
  def initWithCoder(decoder)
    self.statuses_for_deck = decoder.decodeObjectForKey(KEY_STATUSES) || initial_statuses
    self.fake_flg = decoder.decodeBoolForKey(KEY_FAKE_FLG) || false
    self
  end

  # @param [NSCoder] encoder
  def encodeWithCoder(encoder)
    encoder.encodeObject(self.statuses_for_deck, forKey: KEY_STATUSES)
    encoder.encodeBool(self.fake_flg, forKey: KEY_FAKE_FLG)
  end

  def initial_statuses
    [
        SelectedStatus100.new(true)
    ]
  end
end
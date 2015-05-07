class GameSettings
  KEY_STATUSES = 'statuses_for_deck'
  KEY_FAKE_FLG = 'fake_flg'
  KEY_BEGINNER_FLG = 'beginner_flg'
  KEY_SINGER_INDEX = 'singer_index'

  attr_accessor :statuses_for_deck, :fake_flg
  attr_accessor :beginner_flg, :singer_index

  def initialize
    self.statuses_for_deck = initial_statuses
    self.fake_flg = false
    self.beginner_flg = false
    self.singer_index = 0
  end

  # @param [NSCoder] decoder
  def initWithCoder(decoder)
    self.statuses_for_deck = decoder.decodeObjectForKey(KEY_STATUSES) || initial_statuses
    self.fake_flg = decoder.decodeBoolForKey(KEY_FAKE_FLG) || false
    self.beginner_flg = decoder.decodeBoolForKey(KEY_BEGINNER_FLG) || false
    self.singer_index = decoder.decodeIntForKey(KEY_SINGER_INDEX) || 0
    self
  end

  # @param [NSCoder] encoder
  def encodeWithCoder(encoder)
    encoder.encodeObject(self.statuses_for_deck, forKey: KEY_STATUSES)
    encoder.encodeBool(self.fake_flg, forKey: KEY_FAKE_FLG)
    encoder.encodeBool(self.beginner_flg, forKey: KEY_BEGINNER_FLG)
    encoder.encodeInt(self.singer_index, forKey: KEY_SINGER_INDEX)
  end

  def initial_statuses
    [
        SelectedStatus100.new(true)
    ]
  end
end
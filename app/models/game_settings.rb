class GameSettings
  KEY_STATUSES = 'statuses_for_ddeck'

  attr_accessor :statuses_for_deck

  def initialize
    self.statuses_for_deck = initial_statuses
  end

  # @param [NSCoder] decoder
  def initWithCoder(decoder)
    self.statuses_for_deck = decoder.decodeObjectForKey(KEY_STATUSES) || initial_statuses
    self
  end

  # @param [NSCoder] encoder
  def encodeWithCoder(encoder)
    encoder.encodeObject(self.statuses_for_deck, forKey: KEY_STATUSES)
  end

  def initial_statuses
    [
        SelectedStatus100.new(true)
    ]
  end
end
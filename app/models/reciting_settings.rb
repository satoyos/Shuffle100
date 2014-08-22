class RecitingSettings
  DEFAULT_INTERVAL_TIME = 1.10
  DEFAULT_VOLUME = 1.0
  KEY_INTERVAL_TIME = 'interval_time'
  KEY_VOLUME = 'volume'

  attr_accessor :interval_time, :volume
  def initialize
    self.interval_time = DEFAULT_INTERVAL_TIME
    self.volume        = DEFAULT_VOLUME
  end

  # @param [NSCoder] decoder
  def initWithCoder(decoder)
    self.interval_time =
        decoder.decodeObjectForKey(KEY_INTERVAL_TIME) || DEFAULT_INTERVAL_TIME
    self.volume =
        decoder.decodeObjectForKey(KEY_VOLUME) || DEFAULT_VOLUME
    self
  end

  # @param [NSCoder] encoder
  def encodeWithCoder(encoder)
    encoder.encodeObject(self.interval_time, forKey: KEY_INTERVAL_TIME)
    encoder.encodeObject(self.volume,        forKey: KEY_VOLUME)
  end
end
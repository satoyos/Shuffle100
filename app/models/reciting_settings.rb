class RecitingSettings
  DEFAULT_INTERVAL_TIME = 1.10
  DEFAULT_KAMI_SHIMO_INTERVAL = 1.00
  DEFAULT_VOLUME = 1.0
  KEY_INTERVAL_TIME = 'interval_time'
  KEY_KAMI_SHIMO_INTERVAL = 'kami_shimo_interval'
  KEY_VOLUME = 'volume'

  attr_accessor :interval_time, :volume, :kami_shimo_interval

  def initialize
    self.interval_time = DEFAULT_INTERVAL_TIME
    self.kami_shimo_interval = DEFAULT_KAMI_SHIMO_INTERVAL
    self.volume        = DEFAULT_VOLUME
  end

  # @param [NSCoder] decoder
  def initWithCoder(decoder)
    self.interval_time =
        decoder.decodeObjectForKey(KEY_INTERVAL_TIME) || DEFAULT_INTERVAL_TIME
    self.kami_shimo_interval =
        decoder.decodeObjectForKey(KEY_KAMI_SHIMO_INTERVAL) || DEFAULT_KAMI_SHIMO_INTERVAL
    self.volume =
        decoder.decodeObjectForKey(KEY_VOLUME) || DEFAULT_VOLUME
    self
  end

  # @param [NSCoder] encoder
  def encodeWithCoder(encoder)
    encoder.encodeObject(interval_time, forKey: KEY_INTERVAL_TIME)
    encoder.encodeObject(interval_time, forKey: KEY_KAMI_SHIMO_INTERVAL)
    encoder.encodeObject(volume,        forKey: KEY_VOLUME)
  end
end
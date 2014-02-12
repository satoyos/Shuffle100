class RecitingSettings
  DEFAULT_INTERVAL_TIME = 1.10
  DEFAULT_VOLUME = 1.0

  attr_accessor :interval_time, :volume
  def initialize
    self.interval_time = DEFAULT_INTERVAL_TIME
    self.volume        = DEFAULT_VOLUME
  end

  # @param [NSCoder] decoder
  def initWithCoder(decoder)
    self.interval_time = decoder.decodeObjectForKey('interval_time') || DEFAULT_INTERVAL_TIME
    self.volume        = decoder.decodeObjectForKey('volume')        || DEFAULT_VOLUME
    self
  end

  # @param [NSCoder] encoder
  def encodeWithCoder(encoder)
    encoder.encodeObject(self.interval_time, forKey: 'interval_time')
    encoder.encodeObject(self.volume,        forKey: 'volume')
  end
end
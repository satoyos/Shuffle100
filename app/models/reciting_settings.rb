class RecitingSettings
  DEFAULT_INTERVAL_TIME = 1.10
  DEFAULT_VOLUME = 1.0

  attr_accessor :interval_time, :volume

  def initialize
    self.interval_time ||= DEFAULT_INTERVAL_TIME
    self.volume ||= DEFAULT_VOLUME

  end
end
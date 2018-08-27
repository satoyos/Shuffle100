class BW2
  def self.retina_ratio
    UIScreen.mainScreen.scale
  end

  def self.debug=(value)
    @debug_flag = value
  end

  def self.debug?
    @debug_flag ||= false
  end

  def self.ios_version
    @ios_version ||= UIDevice.currentDevice.systemVersion
  end

  def self.ios_major_ver_num
    @ios_major_ver_num ||= ios_version.split(/\./).first.to_i
  end

end

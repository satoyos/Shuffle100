module AudioPlayerFactory
  module_function

  def players
    @players
  end

  # @param [Hash] audio_hash Key=m4aファイルを特定するシンボル, Value=そのファイルのパス(拡張子抜き)のハッシュ
  def prepare_audio_players(audio_hash)
    @players ||= {}
    audio_hash.each do |key, path|
      @players[key] = create_player_by_path(path, ofType: 'm4a')
    end
  end

  def set_volume(val)
    @players.values.each do |player|
      player.volume = val
    end
  end

  def rewind_to_start_point
    @players.values.each do |player|
      player.currentTime = 0.0
    end
  end

  def create_player_by_path(basename, ofType: type)
    audio_session = AVAudioSession.sharedInstance
    audio_session.setActive(true, error: nil)
    # audio_session.setCategory(AVAudioSessionCategoryPlayback, withOptions: AVAudioSessionCategoryOptionMixWithOthers, error: nil)
    audio_session.setCategory(AVAudioSessionCategoryPlayback, error: nil)
    url = NSURL.fileURLWithPath(bundle_by_basename(basename, ofType: type))
    er = Pointer.new(:object)
    player = AVAudioPlayer.alloc.initWithContentsOfURL(url, error: er)
    player.prepareToPlay
    player
  end

  def create_player_of(poem, side: kami_or_shimo)
    path = case kami_or_shimo
             when :kami  ; app_delegate.current_singer_folder +  '/%03da' % poem.number
             when :shimo ; app_delegate.current_singer_folder +  '/%03db' % poem.number
             else        ; raise('Choose :kami or :shimo with "side" parameter')
           end
    create_player_by_path(path, ofType: 'm4a')
  end

  :private

  def bundle_by_basename(basename, ofType: type)
    unless (bundle = NSBundle.mainBundle.pathForResource(basename, ofType: type))
#      bundle = NSBundle.mainBundle.pathForResource(BASENAME_OF_SORRY, ofType: 'm4a')
       raise "Invalid Audio File Path [#{basename}.#{type}]"
    end
    bundle
  end

  def app_delegate
    AppDelegateAccessor.app_delegate
  end

end

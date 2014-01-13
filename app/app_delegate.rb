class AppDelegate

  BAR_TINT_COLOR = '#cee4ae'.to_color #夏虫色
  PROMPT = '百首読み上げ'

  attr_accessor :poem_supplier, :players_hash, :opening_player

  def application(application, didFinishLaunchingWithOptions:launchOptions)
    AudioPlayerFactory.prepare_audio_players(m4a_files_hash)
    self.poem_supplier = PoemSupplier.new
    self.players_hash = AudioPlayerFactory.players
    self.opening_player = self.players_hash[:opening]

    if RUBYMOTION_ENV == 'test'
      return true
    end

    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @recite_controller = RecitePoemController.new
    nav_controller =
        UINavigationController.alloc.
            initWithRootViewController(@recite_controller)
    nav_controller.tap do |nc|
      nc.navigationBar.barTintColor = BAR_TINT_COLOR
      nc.navigationBar.topItem.prompt = PROMPT
      @window.rootViewController = nc
    end

    @window.makeKeyAndVisible
    @recite_controller.recite_opening_poem

    true
  end

  def m4a_files_hash
    hash = {opening: 'audio/序歌'}
    (1..100).each do |number|
      number_str_a = '%03da' % number
      number_str_b = '%03db' % number
      hash[number_str_a] = "audio/#{number_str_a}"
      hash[number_str_b] = "audio/#{number_str_b}"
    end

    hash
  end
end

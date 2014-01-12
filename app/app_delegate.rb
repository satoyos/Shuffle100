class AppDelegate

  BAR_TINT_COLOR = '#cee4ae'.to_color #夏虫色
  PROMPT = '百首読み上げ'

  attr_accessor :deck, :players, :opening_player

  def application(application, didFinishLaunchingWithOptions:launchOptions)
    AudioPlayerFactory.prepare_audio_players(m4a_files_hash)
    self.deck = Deck.new
    self.players = []
    self.opening_player = AudioPlayerFactory.players[:opening]

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
  end
end

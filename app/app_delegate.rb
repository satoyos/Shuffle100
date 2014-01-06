class AppDelegate

  attr_accessor :deck, :players, :opening_player

  def application(application, didFinishLaunchingWithOptions:launchOptions)
    self.deck = Deck.new
    self.players = []

    if RUBYMOTION_ENV == 'test'
      return true
    end

    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    nav_controller =
        UINavigationController.alloc.initWithRootViewController(
            RecitePoemController.new)
    @window.rootViewController = nav_controller

    @window.makeKeyAndVisible

    true
  end
end

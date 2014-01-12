class RecitePoemController < UIViewController
  include RecitePoemDataSource

  OPENING_POEM_TITLE = '序歌'

  attr_reader :deck, :players, :current_player

  def viewDidLoad
    super


    init_properties
    set_rp_view
#    recite_opening_poem

  end

  def play_button_pushed(view, playing: now_playing)
    if now_playing
      @current_player.pause
    else
      @current_player.play
    end
  end

  def audioPlayerDidFinishPlaying(player, successfully:flag)
    if (flag)
      puts '- 読み上げが無事に終了！'
      @rp_view.play_finished_successfully
    end
  end

  def recite_opening_poem
    self.title = OPENING_POEM_TITLE
    @current_player = UIApplication.sharedApplication.delegate.opening_player
    @current_player.delegate = self
    @rp_view.start_reciting
    @current_player.play
  end

  private

  def init_properties
    UIApplication.sharedApplication.delegate.tap do |delegate|
      @deck =    delegate.deck
      @players = delegate.players
    end
    @players.each{|player| player.delegate = self}
  end

  def set_rp_view
    @rp_view = RecitePoemView.alloc.initWithFrame(self.view.frame)
    @rp_view.delegate = WeakRef.new(self)
    @rp_view.dataSource = WeakRef.new(self)
    self.view.addSubview(@rp_view)
  end


end
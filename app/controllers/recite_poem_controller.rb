class RecitePoemController < UIViewController

  OPENING_POEM_TITLE = '序歌'

  attr_reader :deck, :players

  def viewDidLoad
    super


    init_properties
    set_rp_view
    recite_opening_poem

  end

  def play_button_pushed(view, playing: now_playing)
    if now_playing
      @current_player.pause
    else
      @current_player.play
    end
  end

  #%ToDo:  序歌の読み上げの再生が終わったら、自動的に停止状態に移行したいね！
  def audioPlayerDidFinishPlaying(player, successfully:flag)
    puts '- 読み上げが無事に終了！'
    @rp_view.show_play_button_playing
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
    self.view.addSubview(@rp_view)
  end

  def recite_opening_poem
    self.title = OPENING_POEM_TITLE
    @current_player = UIApplication.sharedApplication.delegate.opening_player
    @current_player.delegate = self
    @current_player.play
  end

end
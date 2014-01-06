class RecitePoemController < UIViewController

  OPENING_POEM_TITLE = '序歌'

  attr_reader :deck, :players

  def viewDidLoad
    super

=begin
    @deck =    UIApplication.sharedApplication.delegate.deck
    @players = UIApplication.sharedApplication.delegate.players
=end
    init_properties
    set_rp_view
    recite_opening_poem

  end

  private

  def init_properties
    UIApplication.sharedApplication.delegate.tap do |delegate|
      @deck =    delegate.deck
      @players = delegate.players
    end
  end

  def set_rp_view
    RecitePoemView.alloc.initWithFrame(self.view.frame).tap do |rp_view|
#      rp_view.frame = self.view.bounds
      self.view.addSubview(rp_view)
    end
  end

  def recite_opening_poem
    self.title = OPENING_POEM_TITLE
  end
end
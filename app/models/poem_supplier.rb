class PoemSupplier
  attr_reader :current_index, :poem, :player

  def initialize
    @deck = Deck.new
#    @current_index = 0 # 現在何首めを扱っているか。

  end

  def current_index
    @deck.counter
  end

  def size
    @deck.size
  end

  def kami?
    @kami
  end

  def draw_next_poem
    return false if current_index >= size
    @poem = @deck.next_poem
    @kami = true
    @player = UIApplication.sharedApplication.delegate.players_hash['%03da' % @poem.number]
    true
  end

  def step_into_shimo
    @kami = false
    @player = UIApplication.sharedApplication.delegate.players_hash['%03db' % @poem.number]
  end

end
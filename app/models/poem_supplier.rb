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

  def draw_next_poem
    return false if current_index >= size
    @poem = @deck.next_poem
    @player = AudioPlayerFactory.create_player_by_path('audio/001a', ofType: 'm4a')
    true
  end

end
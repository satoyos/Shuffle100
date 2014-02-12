class PoemSupplier
  attr_reader :poem, :player

  def initialize(init_hash={})
    size = init_hash[:size] || 100
    shuffle_flg = init_hash[:shuffle] || false
    @deck = case  shuffle_flg
             when true ; Deck.new(size).shuffle_with_size(size)
             else      ; Deck.new(size)
    end
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
#    @player = UIApplication.sharedApplication.delegate.players_hash['%03da' % @poem.number]
    @player = current_player
    true
  end

  def step_into_shimo
    @kami = false
    @player = current_player
  end

  def current_player
    path = case @kami
             when true ; 'audio/%03da' % self.poem.number
             else      ; 'audio/%03db' % self.poem.number
           end
    AudioPlayerFactory.create_player_by_path(path, ofType: 'm4a')
  end

end
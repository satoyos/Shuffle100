class PoemSupplier
  include AppDelegateAccessor

  attr_reader :poem

  def initialize(init_hash={})
    if init_hash[:deck]
      puts '- PoemSupplierを、deckを指定する形で初期化しました。' if BW2.debug?
      @deck = init_hash[:deck]
      return
    end
    if init_hash[:special]
      bool100 = (0..99).to_a.map {|idx| false}
      (88..99).to_a.each {|idx| bool100[idx] = true}

      @deck = Deck.create_from_bool100(bool100).shuffle_with_size(bool100.select{|b| b}.size)
      return
    end
    size = limit_size = init_hash[:size] || 100
    if init_hash[:limit] and init_hash[:limit] < limit_size
      limit_size = init_hash[:limit]
    end

    shuffle_flg = init_hash[:shuffle] || false
    @deck = case  shuffle_flg
             when true ; Deck.new(size).shuffle_with_size(limit_size)
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

  def side
    @kami ? :kami : :shimo
  end

  def draw_next_poem
    return false if current_index >= size
    @poem = @deck.next_poem
    @kami = true
    # @player = current_player
    true
  end

  # @return [Boolean] デッキの1つ前の歌に戻れればtrueを、戻れなければfalse
  def rollback_prev_poem
    @poem = @deck.rollback_poem
    return false unless @poem
    @kami = false
    true
  end

  def step_into_shimo
    @kami = false
  end

  def step_back_to_kami
    @kami = true
  end
end
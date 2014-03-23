class Deck
#  PROPERTIES = [:poems, :counter, :poems100]
  PROPERTIES = [:poems, :counter]
  PROPERTIES.each do |prop|
    attr_accessor prop
  end

  JSON_FILE = '100.json'

  class << self
    def original_deck
      @original_deck ||= self.new
    end

    def original_poems
      self.original_deck.poems
    end

    def create_from_bool100(bool100)
      self.new.select_from_bool100(bool100)
    end

  end

  def initialize(size=100)
    read_poems(size)
    @counter = 0
  end

  def read_poems(size)
    path = App.resources_path.stringByAppendingPathComponent JSON_FILE
    @poems = BW::JSON.parse(File.read(path)).map{|poem_hash| Poem.new(poem_hash)}[0..size-1]
  end

  def next_poem
#    puts '++ coming into [next_poem]'
    if @counter == @poems.size
      return nil
    end
    @counter += 1
    @poems[@counter-1]
  end

  def size
    @poems.size
  end

  def shuffle_with_size(new_size)
    return nil if new_size > self.size
    @poems = (@poems.shuffle)[0..new_size-1]
    self
  end

  def shuffle
    shuffle_with_size(self.size)
  end

  def add_fake_poems
    joining_num = (self.size <= 50) ? self.size : 100 - self.size
    new_poem_numbers =
        ((1..100).to_a - self.poems.map{|poem| poem.number}).shuffle.slice(0, joining_num)
    @poems = (@poems + new_poem_numbers.map{|num| self.class.original_poems[num-1]}).shuffle
    self
  end

  :protected

  def select_from_bool100(bool100)
    raise 'use array[100] for select_from_bool100:' unless bool100.size == 100
    raise "number of poems in deck => #{@poems.size}" unless @poems.size == 100
    poems = []
    @poems.each_with_index do |poem, idx|
      poems << poem if bool100[idx]
    end
    @poems = poems
    self
  end

  def rollback_poem
    case @counter
      when 0 ; nil
      when 1
        @counter = 0
        nil
      else
        @counter -= 1
        @poems[@counter-1]
    end

  end

end
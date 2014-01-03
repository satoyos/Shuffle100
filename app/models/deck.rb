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

  def initialize
    read_poems
    @counter = 0
  end

  def read_poems
    path = App.resources_path.stringByAppendingPathComponent JSON_FILE
    @poems = BW::JSON.parse(File.read(path)).map{|poem_hash| Poem.new(poem_hash)}
  end

  def next_poem
#    puts '++ coming into [next_poem]'
    if @counter == @poems.size
      return nil
    end
    poem = @poems[@counter]
    @counter += 1
    poem
  end

  def size
    @poems.size
  end

  def shuffle_with_size(new_size)
    return nil if new_size > self.size
    @poems = @poems.shuffle[0..new_size-1]
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


end
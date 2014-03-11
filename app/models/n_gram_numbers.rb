class NGramNumbers

  FIRST_CHARS = {
      mu:  'む', su:  'す', me:  'め', fu:  'ふ', sa:  'さ', ho:  'ほ', se:  'せ',
      u:   'う', tsu: 'つ', shi: 'し', mo:  'も', yu:  'ゆ',
      i:   'い', chi: 'ち', hi:  'ひ', ki:  'き',
      ha:  'は', ya:  'や', yo:  'よ', ka:  'か',
      mi:  'み',
      ta:  'た', ko:  'こ',
      o:   'お', wa:  'わ',
      na:  'な',
      a:   'あ'
  }

  ICHI_MAI_FUDA = [:mu, :su, :me, :fu, :sa, :ho, :se]

  class << self
    def of(char_sym)
      @numbers ||= NGramNumbers.new
      @numbers.list[char_sym]
    end

    def numbers_of(char_sym)
      self.of(char_sym)
    end

    def indexes_of(char_sym)
      @numbers ||= NGramNumbers.new
      @numbers.list[char_sym].map{|number| number-1}
    end
  end

  attr_reader :poems, :list

  def initialize
    @poems = Deck.original_poems
    @list = list_of_first_chars
  end

  :private

  def list_of_first_chars
    list = {}
    FIRST_CHARS.each do |key, value|
      list[key] = @poems.select{|poem| poem.kimari_ji[0] == value}.map{|poem| poem.number}
    end
    list[:just_one] = ICHI_MAI_FUDA.inject([]){|result, sym| result + list[sym]}
    list
  end
end
class GameSettings
  KEY_STATUSES = 'statuses_for_deck'
  KEY_FAKE_FLG = 'fake_flg'
  KEY_BEGINNER_FLG = 'beginner_flg'
  KEY_SINGER_INDEX = 'singer_index'
  KEY_RECITE_MODE_ID = 'recite_mode_id'
  KEY_FUDA_SETS = 'fuda_sets'

  attr_accessor :statuses_for_deck, :fake_flg
  attr_accessor :singer_index, :fuda_sets
  attr_reader :beginner_flg, :recite_mode_id

  def initialize
    self.statuses_for_deck = initial_statuses
    self.fake_flg = false
    self.singer_index = 0
=begin
    self.beginner_flg = false
    self.recite_mode_id = :normal
=end
    set_recite_mode(:normal)
    self.fuda_sets = []
  end

  # @param [NSCoder] decoder
  def initWithCoder(decoder)
    self.statuses_for_deck = decoder.decodeObjectForKey(KEY_STATUSES) || initial_statuses
    self.fake_flg = decoder.decodeBoolForKey(KEY_FAKE_FLG) || false
    if (flg = decoder.decodeBoolForKey(KEY_BEGINNER_FLG)).nil?
      set_recite_mode(:normal)
    else
      @beginner_flg = flg
      @recite_mode_id = fix_recite_mode_id(decoder)
    end
    self.singer_index = decoder.decodeIntForKey(KEY_SINGER_INDEX) || 0
    self.fuda_sets = decoder.decodeObjectForKey(KEY_FUDA_SETS) || []
    self
  end

  # @param [NSCoder] encoder
  def encodeWithCoder(encoder)
    encoder.encodeObject(self.statuses_for_deck, forKey: KEY_STATUSES)
    encoder.encodeBool(self.fake_flg, forKey: KEY_FAKE_FLG)
    encoder.encodeBool(self.beginner_flg, forKey: KEY_BEGINNER_FLG)
    encoder.encodeInt(self.singer_index, forKey: KEY_SINGER_INDEX)
    encoder.encodeObject(self.recite_mode_id, forKey: KEY_RECITE_MODE_ID)
    encoder.encodeObject(self.fuda_sets, forKey: KEY_FUDA_SETS)
  end

  def initial_statuses
    [
        SelectedStatus100.new(true)
    ]
  end

  def set_recite_mode(mode)
    case mode
      when :normal
        @beginner_flg = false
        @recite_mode_id = :normal
      when :nonstop
        @beginner_flg = false
        @recite_mode_id = :nonstop
      when :beginner
        @beginner_flg = true
        @recite_mode_id = :beginner
        self.fake_flg = false
      else
        raise("Unsupported recite mode [#{mode}]")
    end
  end

  def needs_kami_shimo_interval?
    @recite_mode_id != :normal
  end

  private

  def fix_recite_mode_id(decoder)
    fetch_data = decoder.decodeObjectForKey(KEY_RECITE_MODE_ID)
    case fetch_data
      when nil ; :normal
      else     ; fetch_data.to_sym
    end
  end
end
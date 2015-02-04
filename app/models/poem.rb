 class Poem
  DEFAULT_LABEL_PATTERN = 'poem%03d'
  DEFAULT_STR_OUT_PATTERN = '%d. %s %s %s %s %s'
  PROPERTIES = [:number, :poet, :liner, :in_hiragana, :in_modern_kana, :kimari_ji, :living_years]
  PROPERTIES.each do |prop|
    attr_accessor prop
  end

  def initialize(attributes = {})
    attributes.each do  |key, value|
      self.send("#{key}=", value) if PROPERTIES.member? key.to_sym
    end
    self.in_hiragana = Liner_2_parts.new(self.in_hiragana)
    @kimari_ji = @kimari_ji.gsub(/　/, '')
  end

  def str_with_number_and_liner(pattern=nil)
    out_pattern = pattern ? pattern : DEFAULT_STR_OUT_PATTERN
    out_pattern % ([number] + (0..4).to_a.map{|idx| liner[idx]})
  end
 end
 class Poem
  DEFAULT_LABEL_PATTERN = 'poem%03d'
  PROPERTIES = [:number, :poet, :liner, :in_hiragana, :kimari_ji]
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
end
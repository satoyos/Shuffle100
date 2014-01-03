class Liner_2_parts
  PROPERTIES = [:kami, :shimo]
  PROPERTIES.each do |prop|
    attr_reader prop
  end

  def initialize(init_hash)
    @kami  = init_hash[:kami]
    @shimo = init_hash[:shimo]
  end

end
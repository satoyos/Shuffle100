class Singer
  attr_accessor :id, :name, :path

  SINGERS_DATA = [
      {
          id: :ia,
          name: 'IA（ボーカロイド）',
          path: 'resources/audio/ia',
      },
      {
          id: :inaba,
          name: 'いなばくん（人間）',
          path: 'resources/audio/inaba',
      }
  ]

  def initialize(init_hash)
    init_hash.each do |key, value|
      raise unless self.respond_to? "#{key}="
      self.send("#{key}=".to_sym, value)
    end
  end

  class << self
    def singers
      @singers ||= SINGERS_DATA.map{|hash| Singer.new(hash)}
    end

    def default_singer
      singers.first
    end
  end
end
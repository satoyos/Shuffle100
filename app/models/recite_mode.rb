class ReciteMode
  attr_accessor :id, :name, :description

  RECITE_MODE_DATA = [
      {
          id: :normal,
          name: '通常',
          description: '（競技かるた）',
      },
      {
          id: :beginner,
          name: '初心者',
          description: '（散らし取り）'
      },
      {
          id: :nonstop,
          name: 'ノンストップ',
          description: '（止まらない）'
      }
  ]

  def initialize(init_hash)
    init_hash.each do |key, value|
      raise unless self.respond_to? "#{key}="
      self.send("#{key}=".to_sym, value)
    end
  end

  class << self
    def recite_modes
      @recite_modes ||= RECITE_MODE_DATA.map{|hash| ReciteMode.new(hash)}
    end

    def default_recite_mode
      recite_modes.first
    end

    def get_recite_mode_of_id(id)
      recite_modes.find{|rm| rm.id == id}
    end

    def get_idx_of_recite_mode_id(id)
      recite_modes.index{|rm| rm.id == id}
    end

  end
end
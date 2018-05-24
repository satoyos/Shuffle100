class FudaSet
  attr_accessor :name, :status100

  KEY_FUDA_SET_NAME = 'fuda_set_name'

  def initialize(name, status100)
    raise '札セットの初期化時に名前を文字列で指定してください' if name.nil? || !name.is_a?(String)
    raise '札セットの初期化時に、札の構成をBoolenanの配列で指定してください' if status100.nil? || !status100.is_a?(SelectedStatus100)
    @name = name
    @status100 = status100
  end

  # NSCoding Protocol

  def initWithCoder(decoder)
    @status100 = decoder.decodeObjectForKey(SelectedStatus100::KEY_STATUS)
    @name = decoder.decodeObjectForKey(KEY_FUDA_SET_NAME)
    self
  end

  def encodeWithCoder(encoder)
    # puts 'ヽ(`Д´)ﾉ エンコーダに入ったからね！！' if BW2.debug?
    encoder.encodeObject(self.status100, forKey: SelectedStatus100::KEY_STATUS)
    encoder.encodeObject(self.name, forKey: KEY_FUDA_SET_NAME)
  end
end
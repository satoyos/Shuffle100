class FudaSet
  attr_reader :name, :status100

  def initialize(name, status100)
    raise '札セットの初期化時に名前を文字列で指定してください' if name.nil? || !name.is_a?(String)
    raise '札セットの初期化時に、札の構成をBoolenanの配列で指定してください' if status100.nil? || !status100.is_a?(SelectedStatus100)
    @name = name
    @status100 = status100
  end
end
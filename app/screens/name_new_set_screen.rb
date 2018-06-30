class NameNewSetScreen < PM::Screen
  STR_NAME_NEW_SET = '新しい札セットの名前'

  title STR_NAME_NEW_SET

  attr_reader :layout

  def on_load
    # self.view.backgroundColor = :white.uicolor
    @layout = NameNewSetLayout.new
    self.view = layout.view
  end

end
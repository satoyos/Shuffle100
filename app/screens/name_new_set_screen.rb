class NameNewSetScreen < PM::Screen
  STR_NAME_NEW_SET = '新しい札セットの名前'

  title STR_NAME_NEW_SET

  attr_reader :layout

  def on_load
    @layout = NameNewSetLayout.new
    self.view = layout.view
    set_button_actions
  end

  private

  def set_button_actions
    layout.get(:cancel_button).addTarget(self,
                                         action: 'cancel_button_pushed',
                                         forControlEvents: UIControlEventTouchUpInside)
  end

  def cancel_button_pushed
    close
  end

end
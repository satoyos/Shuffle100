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
    layout.get(:fix_button).addTarget(self,
                                         action: 'fix_button_pushed',
                                         forControlEvents: UIControlEventTouchUpInside)

    layout.get(:cancel_button).addTarget(self,
                                         action: 'cancel_button_pushed',
                                         forControlEvents: UIControlEventTouchUpInside)
  end

  def cancel_button_pushed
    close value: :cancel
  end

  def fix_button_pushed
    close value: :fix, name: fuda_set_name
  end

  def fuda_set_name
    layout.get(:name_field).text
  end

end
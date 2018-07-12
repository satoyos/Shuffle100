class NameNewSetScreen < PM::Screen
  STR_NAME_NEW_SET = '新しい札セットの名前'

  title STR_NAME_NEW_SET

  attr_reader :layout

  def on_load
    set_view_with_layout
    set_button_actions
    set_text_field_delegate
  end

  def textFieldShouldReturn(text_field)
    hyde_keyboard
    true
  end

  def touchesBegan(touches, withEvent: event)
    layout.get(:name_field).tap do |field|
        field.resignFirstResponder if field.isFirstResponder
    end

  end

  private

  def set_view_with_layout
    @layout = NameNewSetLayout.new
    self.view = layout.view
  end

  def set_text_field_delegate
    layout.get(:name_field).delegate = self
  end

  def set_button_actions
    layout.get(:fix_button).addTarget(self,
                                         action: 'fix_button_pushed',
                                         forControlEvents: UIControlEventTouchUpInside)

    layout.get(:cancel_button).addTarget(self,
                                         action: 'cancel_button_pushed',
                                         forControlEvents: UIControlEventTouchUpInside)
  end

  def cancel_button_pushed
    hyde_keyboard
    close value: :cancel
  end

  def fix_button_pushed
    hyde_keyboard
    close value: :fix, name: fuda_set_name
  end

  def hyde_keyboard
    layout.get(:name_field).resignFirstResponder
  end

  def fuda_set_name
    layout.get(:name_field).text
  end

end
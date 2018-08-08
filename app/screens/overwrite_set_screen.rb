class OverwriteSetScreen < PM::Screen
  include InitPickerView
  include OverwriteSetScreenDataSource
  include OverwriteSetScreenDelegate
  include NormalButtonColors

  title '上書きする札セットを選ぶ'

  attr_reader :fuda_sets, :picker_view, :fix_button, :cancel_button

  def on_load
    init_base_view
    fetch_fuda_sets
    set_picker_view(true)
    set_buttons
  end

  def should_autorotate
    false
  end

  def numberOfComponentsInPickerView(pickerView)
    1
  end

  def pickerView(pickerView, numberOfRowsInComponent: component)
    fuda_sets.size
  end

  def pickerView(pickerView, widthForComponent: component)
    view.frame.size.width
  end

  private

  def init_base_view
    view.backgroundColor = :white.uicolor
  end

  def fetch_fuda_sets
    @fuda_sets = app_delegate.game_settings.fuda_sets
  end

  def set_buttons
    set_cancel_button
    set_fix_button
  end
  
  def set_fix_button
    @fix_button = UIButton.new.tap do |fb|
      fb.frame = CGRectMake(half_width_of_screen, buttons_org_y_margin,
                            half_width_of_screen, buttons_height)
      fb.setTitle('上書きする', forState: :normal.uicontrolstate)
      set_button_title_color(fb)
      fb.on(:touch) {fix_button_pushed}
    end
    view.addSubview(@fix_button)
  end


  def set_cancel_button
    @cancel_button = UIButton.new.tap do |cb|
      cb.frame = CGRectMake(0, buttons_org_y_margin,
                            half_width_of_screen, buttons_height)
      cb.setTitle('キャンセル', forState: :normal.uicontrolstate)
      set_button_title_color(cb)
      cb.on(:touch) {cancel_button_pushed}
    end
    view.addSubview(@cancel_button)
  end

  def half_width_of_screen
    view.frame.size.width / 2
  end

  def buttons_height
    50
  end

  def buttons_org_y_margin
    picker_view.frame.origin.y + picker_view.frame.size.height
  end

end
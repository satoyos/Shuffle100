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

  def set_buttons
    @cancel_button = UIButton.new.tap do |cb|
      cb.frame = CGRectMake(0, picker_view.frame.origin.y + picker_view.frame.size.height,
                       view.frame.size.width/2, 50)
      cb.setTitle('キャンセル', forState: :normal.uicontrolstate)
      set_button_title_color(cb)
      cb.on(:touch){cancel_button_pushed}
    end
    view.addSubview(@cancel_button)

  end

  def init_base_view
    view.backgroundColor = :white.uicolor
  end

  def fetch_fuda_sets
    @fuda_sets = app_delegate.game_settings.fuda_sets
  end

end
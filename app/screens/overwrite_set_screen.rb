class OverwriteSetScreen < PM::Screen
  include InitPickerView
  include OverwriteSetScreenDataSource
  include OverwriteSetScreenDelegate

  title '上書きする札セットを選ぶ'

  attr_reader :fuda_sets, :picker_view

  def on_load
    init_base_view
    fetch_fuda_sets
    set_picker_view(true)
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

end
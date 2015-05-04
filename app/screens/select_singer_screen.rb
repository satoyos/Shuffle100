class SelectSingerScreen < PM::Screen
  title '読手を選ぶ'
  PICKER_VIEW_ACC_LABEL = 'picker_view'

  attr_reader :singers, :picker_view

  def on_load
    init_base_view
    fetch_singers
    set_picker_view
  end

  def will_appear
    self.navigationItem.prompt = app_delegate.prompt
  end

  def should_autorotate
    false
  end

  def numberOfComponentsInPickerView(pickerView)
    1
  end

  def pickerView(pickerView, numberOfRowsInComponent: component)
    singers.size
  end

  def pickerView(pickerView, titleForRow: row, forComponent: component)
    singers[row].name
  end

  def pickerView(pickerView, widthForComponent: component)
    view.frame.size.width
  end

  private

  def init_base_view
    view.backgroundColor = :white.uicolor
  end

  def fetch_singers
    @singers = Singer.singers
  end

  def set_picker_view
    @picker_view = UIPickerView.alloc.init
    @picker_view.tap do |p_view|
      p_view.delegate = self
      p_view.dataSource = self
      p_view.showsSelectionIndicator = true
      p_view.selectRow(0, inComponent: 0, animated: false)
      p_view.accessibilityLabel = PICKER_VIEW_ACC_LABEL
      view.addSubview(p_view)
    end
  end

end
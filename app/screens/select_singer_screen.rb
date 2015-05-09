class SelectSingerScreen < PM::Screen
  include SelectSingerScreenDelegate

  title '読手を選ぶ'
  PICKER_VIEW_ACC_LABEL = 'picker_view'
  COMPONENT_ID = 0

  attr_reader :singers, :picker_view

  def on_load
    init_base_view
    fetch_singers
    set_picker_view
  end

  def will_appear
    self.navigationItem.prompt = app_delegate.prompt
    picker_view.selectRow(app_delegate.game_settings.singer_index,
                          inComponent: COMPONENT_ID,
                          animated: false)
  end

  def will_disappear
    app_delegate.game_settings.singer_index = picker_view.selectedRowInComponent(COMPONENT_ID)
    app_delegate.settings_manager.save
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
      p_view.selectRow(0, inComponent: COMPONENT_ID, animated: false)
      p_view.accessibilityLabel = PICKER_VIEW_ACC_LABEL
      view.addSubview(p_view)
    end
  end

end
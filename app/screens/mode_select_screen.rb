class ModeSelectScreen < PM::Screen
  include ModeSelectScreenDelegate

  title '読み上げモードを選ぶ'
  PICKER_VIEW_ACC_LABEL = 'picker_view'
  COMPONENT_ID = 0

  attr_reader :recite_modes, :picker_view

  def on_load
    init_base_view
    fetch_recite_modes
    set_picker_view
  end

  def will_appear
    self.navigationItem.prompt = app_delegate.prompt
    picker_view.selectRow(ReciteMode.get_idx_of_recite_mode_id(app_delegate.game_settings.recite_mode_id),
                          inComponent: COMPONENT_ID,
                          animated: false)
  end

  def will_disappear
    app_delegate.game_settings.set_recite_mode(current_mode.id)
    app_delegate.settings_manager.save
  end

  def should_autorotate
    false
  end

  def numberOfComponentsInPickerView(pickerView)
    1
  end

  def pickerView(pickerView, numberOfRowsInComponent: component)
    recite_modes.size
  end

  private

  def init_base_view
    view.backgroundColor = :white.uicolor
  end

  def fetch_recite_modes
    @recite_modes = ReciteMode.recite_modes
  end

  def set_picker_view
    @picker_view = UIPickerView.alloc.init
    @picker_view.tap do |p_view|
      p_view.delegate = self
      p_view.dataSource = self
      p_view.frame = [
          [0, 0],
          [view.frame.size.width, picker_view.frame.size.height]
      ]
      p_view.showsSelectionIndicator = true
      p_view.selectRow(0, inComponent: COMPONENT_ID, animated: false)
      p_view.accessibilityLabel = PICKER_VIEW_ACC_LABEL
      view.addSubview(p_view)
    end
  end

  def current_mode
    recite_modes[current_mode_idx]
  end

  def current_mode_idx
    picker_view.selectedRowInComponent(COMPONENT_ID)
  end

end
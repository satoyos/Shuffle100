class ModeSelectScreen < PM::Screen
  include ModeSelectScreenDelegate
  include InitPickerView

  title '読み上げモードを選ぶ'

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

  def current_mode
    recite_modes[current_mode_idx]
  end

  def current_mode_idx
    picker_view.selectedRowInComponent(COMPONENT_ID)
  end

end
module OverwriteSetScreenDelegate
  COMPONENT_ID = 0

  def fix_button_pushed
    puts '上書き決定ボタンが押された！' if BW2.debug?
    close mode: :fix_overwritten, index: current_set_index
  end

  def cancel_button_pushed
    puts 'キャンセルボタンが押された！' if BW2.debug?
    close
  end

  def current_set_index
    picker_view.selectedRowInComponent(COMPONENT_ID)
  end
end
module OverwriteSetScreenDelegate
  def fix_button_pushed
    puts '上書き決定ボタンが押された！' if BW2.debug?
    close
  end

  def cancel_button_pushed
    puts 'キャンセルボタンが押された！' if BW2.debug?
    close
  end
end
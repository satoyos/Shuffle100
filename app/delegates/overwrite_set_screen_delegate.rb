module OverwriteSetScreenDelegate
  def cancel_button_pushed
    puts 'キャンセルボタンが押された！' if BW2.debug?
    close
  end
end
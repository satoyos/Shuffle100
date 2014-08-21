class WhatsNextLayout < MotionKit::Layout
  include NormalButtonStyles

  def layout
    background_color :white.uicolor
    add UIButton, :refrain_button
    add UIButton, :next_poem_button
  end

  def refrain_button_style
    size ['80%', 30]
    center ['50%', '50%']
    title '下の句をもう一度読む'
    set_button_title_color
  end

  def next_poem_button_style
    title '次の歌へ！'
    constraints do
      size.equals(:refrain_button)
    end
    center ['50%', '70%']
    set_button_title_color
  end

  private

=begin
  def set_button_title_color
    title_color :blue.uicolor
    title_color :red.uicolor, state: :highlighted.uicontrolstate
  end
=end
end
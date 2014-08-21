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
    accessibility_label 'refrain_button'
    set_button_title_color
  end

  def next_poem_button_style
    title '次の歌へ！'
    constraints do
      size.equals(:refrain_button)
    end
    center ['50%', '70%']
    accessibility_label 'next_poem_button'
    set_button_title_color
  end
end
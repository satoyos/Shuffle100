class WhatsNextLayout < MotionKit::Layout
  include NormalButtonStyles

  def layout
    background_color :white.uicolor
    add WhatsNextButton, :refrain_button
    add WhatsNextButton, :next_poem_button
  end

  def refrain_button_style
    size ['90%', 50]
    origin x: 0
    center y: '30%'
    init_title_style_and_image('refrain.png')
    title '下の句をもう一度読む'
    accessibility_label 'refrain_button'
  end

  def next_poem_button_style
    size ['90%', 50]
    origin x: 0
    center y: '60%'
    init_title_style_and_image('go_next.png')
    title '次の歌へ！      '
    accessibility_label 'next_poem_button'
  end
end
class WhatsNextLayout < MotionKit::Layout
  include NormalButtonStyles

  attr_accessor :sizes

  def layout
    background_color :white.uicolor
    add WhatsNextButton, :refrain_button
    add WhatsNextButton, :next_poem_button
  end

  def refrain_button_style
    size ['100%', whats_next_button_height]
    origin x: 0
    center y: '30%'
    init_title_style_and_image('refrain.png')
    title '下の句をもう一度読む'
    font MDT::Font.body
    set_insets
    accessibility_label 'refrain_button'
  end

  def next_poem_button_style
    size ['100%', whats_next_button_height]
    origin x: 0
    center y: '60%'
    init_title_style_and_image('go_next.png')
    title '次の歌へ！      '
    font MDT::Font.body
    set_insets
    accessibility_label 'next_poem_button'
  end

  private

  def set_insets
    image_edge_insets UIEdgeInsetsMake(
                          0, image_offset_x,
                          0, super_view_width - whats_next_button_height -
                               image_offset_x)
    title_edge_insets UIEdgeInsetsMake(
                          0, -1 * whats_next_button_height * (BW2.retina_ratio-1),
                          0, 0)
  end

  def whats_next_button_height
    sizes.whats_next_button_height
  end

  def image_offset_x
    sizes.image_offset_x
  end

  def super_view_width
    superview.frame.size.width
  end
end
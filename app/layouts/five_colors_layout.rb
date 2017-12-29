class FiveColorsLayout < MotionKit::Layout
  include NormalButtonStyles

  attr_accessor :sizes

  def layout
    background_color :white.uicolor
    add WhatsNextButton, :blue_group_button
    add WhatsNextButton, :pink_group_button
    # add WhatsNextButton, :next_poem_button
    # add WhatsNextButton, :torifuda_button
  end

  def blue_group_button_style
    typical_button_styling
    center y: '10%'
    init_title_style_and_image('5colors/blue.png')
    title '青'
    set_insets
    accessibility_label 'blue_gruop_button'
  end

  def pink_group_button_style
    typical_button_styling
    center y: '30%'
    init_title_style_and_image('5colors/pink.png')
    title '桃 (ピンク)'
    set_insets
    accessibility_label 'blue_gruop_button'
  end

  private

  def typical_button_styling
    size ['100%', whats_next_button_height]
    origin x: 0
    self.titleLabel.textAlignment = :left.nstextalignment
  end

  def set_insets
    image_edge_insets UIEdgeInsetsMake(
                          0, image_offset_x,
                          0, super_view_width - whats_next_button_height -
                               image_offset_x)
    title_edge_insets UIEdgeInsetsMake(
                          0, -2 * whats_next_button_height * (BW2.retina_ratio-1),
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
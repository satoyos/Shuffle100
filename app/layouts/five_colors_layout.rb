class FiveColorsLayout < MotionKit::Layout
  include NormalButtonStyles
  include FiveColors

  attr_accessor :sizes

  def layout
    background_color :white.uicolor
    FIVE_COLOR_SYMBOLS.each {|color_sym|
      add WhatsNextButton, "#{color_sym}_group_button".to_sym
    }
  end

  def blue_group_button_style
    button_style_of_color(:blue)
  end

  def pink_group_button_style
    button_style_of_color(:pink)
  end

  def yellow_group_button_style
    button_style_of_color(:yellow)
  end

  def green_group_button_style
    button_style_of_color(:green)
  end

  def orange_group_button_style
    button_style_of_color(:orange)
  end

  private

  CENTER_Y_POSITIONS = {
      blue:   '10%',
      pink:   '25%',
      yellow: '40%',
      orange: '55%',
      green:  '70%'
  }

  def button_style_of_color(color_sym)
    typical_button_styling
    center y: CENTER_Y_POSITIONS[color_sym]
    init_title_style_and_image("5colors/#{color_sym}.png")
    title str_of_color(color_sym)
    set_insets
    accessibilityLabel "#{color_sym}_group_button"
  end

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
    # sizes.five_colors_button_height
  end

  def image_offset_x
    sizes.image_offset_x
  end

  def super_view_width
    superview.frame.size.width
  end
end
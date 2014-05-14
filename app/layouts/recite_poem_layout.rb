class RecitePoemLayout < MotionKit::Layout
  BUTTON_IMAGE_SIZE = CGSizeMake(30, 30)
=begin
  QUIT_IMAGE = ResizeUIImage.resizeImage(UIImage.imageNamed('exit_square_org.png'),
                                         newSize: BUTTON_IMAGE_SIZE)
  GEAR_IMAGE = ResizeUIImage.resizeImage(UIImage.imageNamed('gear-520.png'),
                                         newSize: BUTTON_IMAGE_SIZE)
=end
  HEADER_BUTTON_SIZE = 40

  def layout
    background_color UIColor.whiteColor


    add UIView, :header do
      add UILabel, :header_title do
        text '序歌'
      end
      add UIButton, :gear_button
    end

    # header
    # play_button
    # progress_bar
  end

  def header_style
    background_color AppDelegate::BAR_TINT_COLOR
    frame [[0, 0], ['100%', 60]]
  end

  def header_title_style
    text_alignment UITextAlignmentCenter
    size [100, 40]
    center ['50%', '50% + 10']
  end

  def gear_button_style
    image self.class.gear_image, state: UIControlStateNormal
    # title 'test'
    frame w:30, h:30
    center ['50%', '50% + 10']
    frame x: 10
    # frame from_bottom(h: HEADER_BUTTON_SIZE, w: HEADER_BUTTON_SIZE)
  end

=begin
  def add_constraints
    constraints(:header) do
      top_left x: 0, y: 0
      width.equals(view)
      height 60
    end

    constraints(:header_title) do
      size [100, 40]
      center ['50%', '50% + 10']
    end

  end
=end

  class << self
    def gear_image
      @gear_image ||= ResizeUIImage.resizeImage(UIImage.imageNamed('gear-520.png'),
                                                newSize: BUTTON_IMAGE_SIZE)
    end
  end

end
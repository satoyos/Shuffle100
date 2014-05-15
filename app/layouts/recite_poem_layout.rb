class RecitePoemLayout < MotionKit::Layout
  BUTTON_IMAGE_SIZE = CGSizeMake(30, 30)
  HEADER_BUTTON_SIZE = 25

  def layout
    background_color UIColor.whiteColor

    add UIView, :header do
      add UILabel, :header_title do
        text '序歌'
      end
      add UIButton, :gear_button
      add UIButton, :exit_button
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
    frame w: HEADER_BUTTON_SIZE, h: HEADER_BUTTON_SIZE
    center ['50%', '50% + 10']
    frame x: 10
  end

  def exit_button_style
    image self.class.exit_image, state: UIControlStateNormal
    frame w: HEADER_BUTTON_SIZE, h: HEADER_BUTTON_SIZE
    center ['50%', '50% + 10']
    frame x: "100% - 35"
  end

  class << self
    def gear_image
      @gear_image ||=
          ResizeUIImage.resizeImage(UIImage.imageNamed('gear-520.png'),
                                    newSize: BUTTON_IMAGE_SIZE).
              imageWithRenderingMode(UIImageRenderingModeAlwaysTemplate)
    end

    def exit_image
      @exit_image ||=
          ResizeUIImage.resizeImage(UIImage.imageNamed('exit_square_org.png'),
                                    newSize: BUTTON_IMAGE_SIZE).
              imageWithRenderingMode(UIImageRenderingModeAlwaysTemplate)
    end
  end

end
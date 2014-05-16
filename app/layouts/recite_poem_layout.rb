class RecitePoemLayout < MotionKit::Layout
  STATUS_BAR_HEIGHT = 20 # これはシステムのステータスバーの値そのまま。好きに変えていいわけではない。
  HEADER_HEIGHT = 40
  HEADER_BUTTON_SIZE = 25
  HEADER_BUTTON_MARGIN = 10
  BUTTON_IMAGE_SIZE = CGSizeMake(HEADER_BUTTON_SIZE, HEADER_BUTTON_SIZE)

  def layout
    background_color UIColor.whiteColor

    add UIView, :status_area
    add UIView, :header_container do
      add UILabel, :header_title do
        text '序歌'
      end
      add UIButton, :gear_button
      add UIButton, :exit_button
      # add UIView, :test_view
    end

    # play_button
    # progress_bar
  end

  def status_area_style
    background_color AppDelegate::BAR_TINT_COLOR
    size ['100%', STATUS_BAR_HEIGHT]
  end

  def header_container_style
    background_color AppDelegate::BAR_TINT_COLOR
    frame below(:status_area)
    size ['100%', HEADER_HEIGHT]
  end

  def header_title_style
    text_alignment UITextAlignmentCenter
    size ['80%', '80%']
    center ['50%', '50%']
  end

  def gear_button_style
    image self.class.gear_image, state: UIControlStateNormal
    set_header_button_size
    center y: '50%'
    frame x: HEADER_BUTTON_MARGIN
  end

  def exit_button_style
    image self.class.exit_image, state: UIControlStateNormal
    set_header_button_size
    frame from_top_right(left: HEADER_BUTTON_MARGIN)
    center y: '50%'
  end

  def test_view_style
    background_color UIColor.brownColor
    size [30, 30]
    frame from_top_right(left: 5)
  end

  private

  def set_header_button_size
    frame w: HEADER_BUTTON_SIZE, h: HEADER_BUTTON_SIZE
  end


  class << self
    def gear_image
      @gear_image ||= header_button_from_image_file('gear-520.png')
    end

    def exit_image
      @exit_image ||= header_button_from_image_file('exit_square_org.png')
    end

    def header_button_from_image_file(file_path)
      ResizeUIImage.resizeImage(UIImage.imageNamed(file_path),
                                newSize: BUTTON_IMAGE_SIZE).
          imageWithRenderingMode(UIImageRenderingModeAlwaysTemplate)
    end
  end

end
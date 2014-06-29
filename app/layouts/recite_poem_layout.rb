class RecitePoemLayout < MotionKit::Layout
  STATUS_BAR_HEIGHT = 20 # これはシステムのステータスバーの値そのまま。好きに変えていいわけではない。
  HEADER_HEIGHT = 40
  HEADER_BUTTON_SIZE = 25
  HEADER_BUTTON_MARGIN = 10
  BUTTON_IMAGE_SIZE = CGSizeMake(HEADER_BUTTON_SIZE, HEADER_BUTTON_SIZE)

  PLAY_BUTTON_SIZE = 260
  PLAY_BUTTON_FONT_SIZE = PLAY_BUTTON_SIZE * 0.5

  PLAY_BUTTON_PLAYING_TITLE = FontAwesome.icon('play')
  PLAY_BUTTON_PAUSING_TITLE = FontAwesome.icon('pause')
  PLAY_BUTTON_PLAYING_COLOR = '#007bbb'.to_color # 紺碧
  PLAY_BUTTON_PAUSING_COLOR = '#e2041b'.to_color # 猩々緋

  ACC_LABEL_PLAY_BUTTON = 'play_button'
  ACC_LABEL_PLAY  = 'play'
  ACC_LABEL_PAUSE = 'pause'
  ACC_LABEL_FORWARD =  'forward'
  ACC_LABEL_BACKWARD = 'backward'


  def layout
    root :rp_view do
      add UIView, :status_area
      add UIView, :header_container do
        add UILabel, :header_title do
          text '序歌'
        end
        add UIButton, :gear_button
        add UIButton, :exit_button
      end

      # play_button
      add ReciteViewButton, :play_button


      #%ToDo: 続きは、プログレスバーを配置するところから！

      # progress_bar
    end

  end

  def rp_view_style
    background_color UIColor.whiteColor
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

  def play_button_style
    size [PLAY_BUTTON_SIZE, PLAY_BUTTON_SIZE] # こっちが先であることが重要!!
    center ['50%', '50%'] # centerを決めるのは、sizeが決まってからでないと！
    title 'play'
    init_recite_view_button
    accessibility_label ACC_LABEL_PLAY_BUTTON
    titleLabel.font = FontAwesome.fontWithSize(PLAY_BUTTON_FONT_SIZE)
    set_title(PLAY_BUTTON_PAUSING_TITLE, left_inset: 0,
              color: PLAY_BUTTON_PAUSING_COLOR)
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
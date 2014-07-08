module RecitePoemStyles
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

  # lower_container
  SKIP_BUTTON_SIZE = 30
  SKIP_BUTTON_FONT_SIZE = SKIP_BUTTON_SIZE * 0.5
  SKIP_BUTTON_COLOR = PLAY_BUTTON_PLAYING_COLOR
  FORWARD_BUTTON_TITLE = FontAwesome.icon('fast-forward')
  REWIND_BUTTON_TITLE  = FontAwesome.icon('fast-backward')
  GAP_FROM_BAR = 8

  ACC_LABEL_PLAY_BUTTON = 'play_button'
  ACC_LABEL_PLAY  = 'play'
  ACC_LABEL_PAUSE = 'pause'
  ACC_LABEL_FORWARD =  'forward'
  ACC_LABEL_BACKWARD = 'backward'

  def progress_bar_style
    # progress_view_style UIProgressViewStyleDefault

    # MotionKitのバグかどうか分からないけど、
    # ここでProgressViewの高さを指定しても、2pt固定になる。
    size ['100% - 80', 10]
    center ['50%', '50%']
  end

  def rp_view_style
    background_color UIColor.whiteColor
  end

  def lower_container_style
    size [PLAY_BUTTON_SIZE, SKIP_BUTTON_SIZE]
    frame from_bottom(up: equalized_gap)

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
    frame below(:header_container, down: equalized_gap)
    center x: '50%'
    title 'play'
    init_recite_view_button
    accessibility_label ACC_LABEL_PLAY_BUTTON
    titleLabel.font = FontAwesome.fontWithSize(PLAY_BUTTON_FONT_SIZE)
    set_title(PLAY_BUTTON_PAUSING_TITLE, left_inset: 0,
              color: PLAY_BUTTON_PAUSING_COLOR)
  end

  def rewind_button_style
    size [SKIP_BUTTON_SIZE, SKIP_BUTTON_SIZE]
    origin x: 0
    center y: '50%'
    init_recite_view_button
    accessibility_label ACC_LABEL_BACKWARD
    titleLabel.font = FontAwesome.fontWithSize(SKIP_BUTTON_FONT_SIZE)
    set_title(REWIND_BUTTON_TITLE, left_inset: 0, color: SKIP_BUTTON_COLOR)
  end

  def forward_button_style
    size [SKIP_BUTTON_SIZE, SKIP_BUTTON_SIZE]
    # frame from_right(:lower_container)
    frame after(:progress_bar, right: GAP_FROM_BAR)
    center y: '50%'
    init_recite_view_button
    accessibility_label ACC_LABEL_FORWARD
    titleLabel.font = FontAwesome.fontWithSize(SKIP_BUTTON_FONT_SIZE)
    set_title(FORWARD_BUTTON_TITLE, left_inset: 0, color: SKIP_BUTTON_COLOR)
  end

  private

  def set_header_button_size
    frame w: HEADER_BUTTON_SIZE, h: HEADER_BUTTON_SIZE
  end

  def equalized_gap
    @equalized_gap ||=
        (self.view.frame.size.height -
            (STATUS_BAR_HEIGHT + HEADER_HEIGHT +
                PLAY_BUTTON_SIZE + SKIP_BUTTON_SIZE )) / 3
  end

end
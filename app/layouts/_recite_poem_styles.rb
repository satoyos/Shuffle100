module RecitePoemStyles
  HEADER_HEIGHT = 40
  HEADER_BUTTON_SIZE = 25
  HEADER_BUTTON_MARGIN = 10
  BUTTON_IMAGE_SIZE = CGSizeMake(HEADER_BUTTON_SIZE, HEADER_BUTTON_SIZE)

  PLAY_BUTTON_SIZE = 260
  PLAY_BUTTON_FONT_SIZE = PLAY_BUTTON_SIZE * 0.5
  PLAY_MARK_INSET = PLAY_BUTTON_FONT_SIZE * 0.3
  PLAY_BUTTON_PLAYING_TITLE = FontAwesome.icon('play')
  PLAY_BUTTON_PAUSING_TITLE = FontAwesome.icon('pause')
  PLAY_BUTTON_PLAYING_COLOR = '#007bbb'.uicolor # 紺碧
  PLAY_BUTTON_PAUSING_COLOR = '#e2041b'.uicolor # 猩々緋

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
  ACC_LABEL_BACKWARD = 'rewind'
  ACC_LABEL_GEAR_BUTTON = 'gear_button'
  ACC_LABEL_QUIT_BUTTON = 'quit_button'

  #################
  # 画面上部のView群
  #################

  def rp_view_style
    background_color UIColor.whiteColor
  end

  def header_container_style
    background_color AppDelegate::BAR_TINT_COLOR
    # frame below(:status_area)
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
    accessibility_label ACC_LABEL_GEAR_BUTTON
  end

  def quit_button_style
    image self.class.exit_image, state: UIControlStateNormal
    set_header_button_size
    frame from_top_right(left: HEADER_BUTTON_MARGIN)
    center y: '50%'
    accessibility_label ACC_LABEL_QUIT_BUTTON
  end

  ##################
  # メインのPlayボタン
  ##################

  def play_button_style
    # size [PLAY_BUTTON_SIZE, PLAY_BUTTON_SIZE] # こっちが先であることが重要!!
    size [play_button_size, play_button_size]
    size ['75%', :scale]
    frame below(:header_container, down: equalized_gap)
    center x: '50%'
    title 'play'
    init_recite_view_button(:play_button.to_s)
    accessibility_label ACC_LABEL_PLAY_BUTTON
    # titleLabel.font = FontAwesome.fontWithSize(PLAY_BUTTON_FONT_SIZE)
    titleLabel.font = FontAwesome.fontWithSize(play_button_font_size)
    set_title(PLAY_BUTTON_PAUSING_TITLE, left_inset: 0,
              color: PLAY_BUTTON_PAUSING_COLOR)
  end

  #################
  # 画面下部のView群
  #################

  def lower_container_style
    # (HEADER_HEIGHT + PLAY_BUTTON_SIZE + SKIP_BUTTON_SIZE )) / 3
    # size ['100%', HEADER_HEIGHT]
    size [play_button_size, '7%']
    frame from_bottom(up: equalized_gap)

  end

  def forward_button_style
    size [SKIP_BUTTON_SIZE, SKIP_BUTTON_SIZE]
    size [:scale, '100%']
    # frame from_right(:lower_container)
    frame after(:progress_bar, right: GAP_FROM_BAR)
    center y: '50%'
    init_recite_view_button(:forward_button.to_s)
    accessibility_label ACC_LABEL_FORWARD
    titleLabel.font = FontAwesome.fontWithSize(SKIP_BUTTON_FONT_SIZE)
    set_title(FORWARD_BUTTON_TITLE, left_inset: 0, color: SKIP_BUTTON_COLOR)
  end

  def rewind_button_style
    size [SKIP_BUTTON_SIZE, SKIP_BUTTON_SIZE]
    origin x: 0
    center y: '50%'
    init_recite_view_button(:rewind_button.to_s)
    accessibility_label ACC_LABEL_BACKWARD
    titleLabel.font = FontAwesome.fontWithSize(SKIP_BUTTON_FONT_SIZE)
    set_title(REWIND_BUTTON_TITLE, left_inset: 0, color: SKIP_BUTTON_COLOR)
  end

  def progress_bar_style
    progress_view_style UIProgressViewStyleDefault
    size ['100% - 80', 10]
    center ['50%', '50%']
    # ProgressViewの高さは、frameでは指定できないので、アフィン変換で拡大する。
    transform CGAffineTransformMakeScale(1.0, 2.0)
  end

  private

  def play_button_size
    play_button.frame.size.width
  end

  def play_button_font_size
    play_button_size * 0.5
  end

  def set_header_button_size
    frame w: HEADER_BUTTON_SIZE, h: HEADER_BUTTON_SIZE
  end

  def equalized_gap
    @equalized_gap ||=
        (self.view.frame.size.height -
            # (STATUS_BAR_HEIGHT + HEADER_HEIGHT +
            # (HEADER_HEIGHT + PLAY_BUTTON_SIZE + SKIP_BUTTON_SIZE )) / 3
            (HEADER_HEIGHT + play_button_size + SKIP_BUTTON_SIZE )) / 3
  end

end
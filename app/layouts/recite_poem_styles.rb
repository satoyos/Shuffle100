module RecitePoemStyles
  HEADER_HEIGHT = 40
  HEADER_BUTTON_SIZE = 28
  HEADER_BUTTON_MARGIN = 10
  BUTTON_IMAGE_SIZE = CGSizeMake(HEADER_BUTTON_SIZE, HEADER_BUTTON_SIZE)

  PLAY_BUTTON_PLAYING_TITLE = :play.awesome_icon.string
  PLAY_BUTTON_PAUSING_TITLE = :pause.awesome_icon.string
  PLAY_BUTTON_PLAYING_COLOR = '#007bbb'.uicolor # 紺碧
  PLAY_BUTTON_PAUSING_COLOR = '#e2041b'.uicolor # 猩々緋

  # lower_container
  SKIP_BUTTON_COLOR = PLAY_BUTTON_PLAYING_COLOR
  FORWARD_BUTTON_TITLE = :fast_forward.awesome_icon.string
  REWIND_BUTTON_TITLE  = :fast_backward.awesome_icon.string
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
    size ['100%', HEADER_HEIGHT]
  end

  def header_title_style
    font MDT::Font.body
    text_alignment UITextAlignmentCenter
    size ['80%', '80%']
    center ['50%', '50%']
  end

  def gear_button_style
    set_header_button_size
    set_image_after_frame_is_set
    center y: '50%'
    frame x: HEADER_BUTTON_MARGIN
    accessibility_label ACC_LABEL_GEAR_BUTTON
  end

  def quit_button_style
    set_header_button_size
    set_image_after_frame_is_set
    frame from_top_right(left: HEADER_BUTTON_MARGIN)
    center y: '50%'
    accessibility_label ACC_LABEL_QUIT_BUTTON
  end

  ##################
  # メインのPlayボタン
  ##################

  def play_button_style
    size [play_button_size, play_button_size]
    frame below(:header_container, down: equalized_gap)
    center x: '50%'
    title 'play'
    init_recite_view_button(:play_button.to_s)
    accessibility_label ACC_LABEL_PLAY_BUTTON
    titleLabel.font = MotionAwesome::font(play_button_font_size)
    set_title(PLAY_BUTTON_PAUSING_TITLE, left_inset: 0,
              color: PLAY_BUTTON_PAUSING_COLOR)
  end

  #################
  # 画面下部のView群
  #################

  def lower_container_style
    size [play_button_size, skip_button_size]
    frame from_bottom(up: equalized_gap)
  end

  def forward_button_style
    frame from_right(size: [skip_button_size, skip_button_size])
    init_recite_view_button(:forward_button.to_s)
    accessibility_label ACC_LABEL_FORWARD
    titleLabel.font = MotionAwesome::font(skip_button_font_size)
    set_title(FORWARD_BUTTON_TITLE, left_inset: 0, color: SKIP_BUTTON_COLOR)
  end

  def rewind_button_style
    frame from_left(size: [skip_button_size, skip_button_size])
    init_recite_view_button(:rewind_button.to_s)
    accessibility_label ACC_LABEL_BACKWARD
    titleLabel.font = MotionAwesome::font(skip_button_font_size)
    set_title(REWIND_BUTTON_TITLE, left_inset: 0, color: SKIP_BUTTON_COLOR)
  end

  def progress_bar_style
    progress_view_style UIProgressViewStyleDefault
    frame from_center(size: [superview.frame.size.width - 2*(skip_button_size * 1.2), 0])
    transform CGAffineTransformMakeScale(1.0, 2.0)
  end

  private

  def play_button_size
    sizes.play_button_size
  end

  def play_button_font_size
    play_button_size * 0.5
  end

  def play_mark_inset
    play_button_font_size * 0.3
  end

  def skip_button_size
    sizes.skip_button_size
  end

  def skip_button_font_size
    skip_button_size * 0.5
  end

  def set_header_button_size
    frame w: HEADER_BUTTON_SIZE, h: HEADER_BUTTON_SIZE
  end

  def equalized_gap
    @equalized_gap ||=
        (self.view.frame.size.height -
            (HEADER_HEIGHT + play_button_size + skip_button_size )) / 3
  end
end
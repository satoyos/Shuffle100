class RecitePoemView < UIView
  RP_VIEW_COLOR = UIColor.whiteColor

  PLAY_BUTTON_SIZE = 260
  PLAY_BUTTON_FONT_SIZE = PLAY_BUTTON_SIZE * 0.5
  PLAY_BUTTON_PAUSE_KEY = 'pause' # FontAwesomeのアイコン名から'fa-'を除いたもの
  PLAY_BUTTON_PLAY_KEY  = 'play'
  PLAY_BUTTON_CORNER_RADIUS = PLAY_BUTTON_SIZE / 2.0
  PLAY_MARK_INSET = PLAY_BUTTON_FONT_SIZE * 0.3
  PLAY_BUTTON_PLAYING_TITLE = FontAwesome.icon('play')
  PLAY_BUTTON_PAUSING_TITLE = FontAwesome.icon('pause')
  PLAY_BUTTON_PLAYING_COLOR = '#007bbb'.to_color # 紺碧
  PLAY_BUTTON_PAUSING_COLOR = '#e2041b'.to_color # 猩々緋

  PROGRESS_TIMER_INTERVAL = 0.1

#  GEAR_BUTTON_SIZE = 30

  SKIP_BUTTON_SIZE = 30
  SKIP_BUTTON_FONT_SIZE = SKIP_BUTTON_SIZE * 0.5
  SKIP_BUTTON_COLOR = PLAY_BUTTON_PLAYING_COLOR
  FORWARD_BUTTON_TITLE = FontAwesome.icon('fast-forward')
  REWIND_BUTTON_TITLE  = FontAwesome.icon('fast-backward')

  HEADER_VIEW_HEIGHT = 60

  ACC_LABEL_PLAY_BUTTON = 'play_button'
  ACC_LABEL_PLAY  = 'play'
  ACC_LABEL_PAUSE = 'pause'
  ACC_LABEL_FORWARD =  'forward'
  ACC_LABEL_BACKWORD = 'backward'

  attr_accessor :delegate, :dataSource

#  def init
  def initWithFrame(frame)
    super

    self.backgroundColor = UIColor.whiteColor

    self.addSubview self.play_button
    self.addSubview self.progress_bar
    self.addSubview self.rewind_button
    self.addSubview self.forward_button
    self.addSubview self.header_view
#    self.addSubview self.gear_button

    self
  end

  def layout_with_top_offset(top_offset)
#    self.frame = delegate.view.bounds
    self.frame = delegate.bounds
    self.play_button.layer.cornerRadius = PLAY_BUTTON_SIZE / 2
    [self.rewind_button, self.forward_button].each do |b|
      b.layer.cornerRadius = SKIP_BUTTON_SIZE / 2
    end
#    dummy_nav_bar = create_new_label
    space1 = create_new_label
    space2 = create_new_label
    space3 = create_new_label
#    self.addSubview dummy_nav_bar
    self.addSubview space1
    self.addSubview space2
    self.addSubview space3

    Motion::Layout.new do |layout|
      layout.view self
      layout.subviews 'button'    => self.play_button,
                      'progress'  => self.progress_bar,
#                      'gear'      => self.gear_button,
#                      'nav_bar'   => dummy_nav_bar,
                      'forward'   => self.forward_button,
                      'rewind'    => self.rewind_button,
                      'header'    => self.header_view,
                      's1' => space1,
                      's2' => space2,
                      's3' => space3
      layout.metrics 'margin' => 20, 'height' => 10,
                     'b_size' => PLAY_BUTTON_SIZE,   # Playボタンのサイズは決め打ち
#                     'g_size' => GEAR_BUTTON_SIZE,   # Gearボタンのサイズも決め打ち
                     's_size' => SKIP_BUTTON_SIZE,   # Rewind/Forwadボタンのサイズも決め打ち
                     'h_height' => HEADER_VIEW_HEIGHT
#                     'nav_height' => top_offset,
#                     'top_margin_to_gear' => top_offset + 10

      layout.vertical(
#          '|[nav_bar(nav_height)][s1][button(b_size)][s2(s1)][progress(height)][s3(s1)]|'
          '|[header(h_height)][s1][button(b_size)][s2(s1)][progress(height)][s3(s1)]|'
      )
#      layout.vertical('|-10-[gear(g_size)]')
      layout.vertical('[rewind(s_size)]')
      layout.vertical('[forward(s_size)]')
      layout.horizontal('|-(>=margin)-[button(b_size)]-(>=margin)-|')
      layout.horizontal('|-[rewind(s_size)]-[progress]-[forward(s_size)]-|')
#      layout.horizontal('|-10-[gear(g_size)]')
      layout.horizontal('|[header]|')

    end
#    header_view.layout_subviews
  end

  def title=(str)
    self.header_view.title = str
  end

  def title
    self.header_view.title
  end

  def create_new_label
    UILabel.alloc.initWithFrame(CGRectZero)
  end


  def create_progress_update_timer(interval_time)
    NSTimer.scheduledTimerWithTimeInterval(interval_time,
                                           target: self,
                                           selector: 'update_progress',
                                           userInfo: nil,
                                           repeats: true)
  end

  def update_progress
#    ap "timer(#{timer}).isValid => #{timer.isValid} in update_progress" if BW::debug?

    self.progress_bar.progress = self.delegate.current_player_progress

  end


  def show_waiting_to_pause
    show_play_button_title(PLAY_BUTTON_PAUSING_TITLE,
                             left_inset: 0,
                             color: PLAY_BUTTON_PAUSING_COLOR)
    self.play_button.titleLabel.accessibilityLabel = ACC_LABEL_PAUSE
    @timer = create_progress_update_timer(PROGRESS_TIMER_INTERVAL)
  end

  def show_waiting_to_play
    ap '- 再生の指示待ちです。' if BW::debug?
    @timer.invalidate if @timer
    show_play_button_title(PLAY_BUTTON_PLAYING_TITLE,
                             left_inset: PLAY_MARK_INSET,
                             color: PLAY_BUTTON_PLAYING_COLOR)
    self.play_button.titleLabel.accessibilityLabel = ACC_LABEL_PLAY
  end

  def play_finished_successfully
    @play_button.enabled = false
    @timer.invalidate if @timer and @timer.isValid
  end

  # @return [UIButton]
  def play_button
    return @play_button if @play_button
    @play_button = ReciteViewButton.buttonWithType(UIButtonTypeCustom)
    @play_button.tap do |b|
      b.accessibilityLabel = ACC_LABEL_PLAY_BUTTON
      b.titleLabel.font = FontAwesome.fontWithSize(PLAY_BUTTON_FONT_SIZE)
      b.addTarget(self,
                  action: :play_button_pushed,
                  forControlEvents: UIControlEventTouchUpInside)
    end
    @play_button
  end


  # @return [UIProgressView]
  def progress_bar
    @prrogress_bar ||= UIProgressView.alloc.initWithProgressViewStyle(UIProgressViewStyleDefault)

  end

=begin
  def gear_button
    @gear_button ||=
        UIButton.buttonWithType(UIButtonTypeRoundedRect).tap do |b|
          b.setImage(gear_image, forState: UIControlStateNormal)
          b.addTarget(self,
                      action: 'gear_button_did_pushed:',
                      forControlEvents: UIControlEventTouchUpInside)
          b.accessibilityLabel = ACC_LABEL_GEAR_BUTTON
        end
  end

  def gear_button_did_pushed(sender)
    self.delegate.start_on_game_settings(sender)
  end

  def gear_image
    ResizeUIImage.resizeImage(UIImage.imageNamed('gear_256.png'),
                              newSize: CGSizeMake(GEAR_BUTTON_SIZE, GEAR_BUTTON_SIZE))
  end

=end

  def play_button_pushed
    puts 'play_button pushed!'
    self.delegate.play_button_pushed(self)
  end

  def show_play_button_title(title, left_inset: l_inset, color: color)
    @play_button.tap do |b|
      UIEdgeInsets.new.tap do |insets|
        insets.left = l_inset
        # ↓↓ラベルのテキストを上下中央にするための小細工
#        insets.top = (-1 * b.titleLabel.font.descender) / 1.5
        b.contentEdgeInsets = insets
      end
      b.setTitle(title, forState: UIControlStateNormal)
      b.setTitleColor(color, forState: UIControlStateNormal)
      b.setTitleColor(color.colorWithAlphaComponent(0.25),
                      forState: UIControlStateHighlighted)
      b.setTitleColor(color.colorWithAlphaComponent(0.25),
                      forState: UIControlStateDisabled)
    end
  end

  def rewind_button
    @rewind_button ||=
        create_skip_button('rewind_button', SKIP_BUTTON_COLOR).tap do |b|
          b.setTitle(REWIND_BUTTON_TITLE, forState: UIControlStateNormal)
          b.addTarget(self,
                      action: :rewind_button_pushed,
                      forControlEvents: UIControlEventTouchUpInside)
          b.accessibilityLabel = ACC_LABEL_BACKWORD
        end
  end

  def forward_button
    @forward_button ||=
        create_skip_button('forward_button', SKIP_BUTTON_COLOR).tap do |b|
          b.setTitle(FORWARD_BUTTON_TITLE, forState: UIControlStateNormal)
          b.addTarget(self,
                      action: :forward_button_pushed,
                      forControlEvents: UIControlEventTouchUpInside)
          b.accessibilityLabel = ACC_LABEL_FORWARD
        end
  end

  def rewind_button_pushed
    puts ' - Rewind Button was pushed!' if BW::debug?
    self.delegate.rewind_skip
  end

  def forward_button_pushed
    puts ' - Forward Button was pushed!' if BW::debug?
    self.delegate.forward_skip
  end

  def create_skip_button(acc_label, color)
    ReciteViewButton.buttonWithType(UIButtonTypeCustom).tap do |b|
      b.accessibilityLabel = acc_label
      b.titleLabel.font = FontAwesome.fontWithSize(SKIP_BUTTON_FONT_SIZE)
      b.setTitleColor(color, forState: UIControlStateNormal)
      b.setTitleColor(color.colorWithAlphaComponent(0.25),
                      forState: UIControlStateHighlighted)
      b.setTitleColor(color.colorWithAlphaComponent(0.25),
                      forState: UIControlStateDisabled)

    end
  end

  def header_view
    @header_view ||=
        ReciteHeaderView.alloc.initWithFrame(header_view_frame)
=begin
        ReciteHeaderView.alloc.initWithFrame(header_view_frame).tap do |view|
          view.backgroundColor = AppDelegate::BAR_TINT_COLOR
        end
=end
  end

  def header_view_frame
    [[0, 0],
     [self.frame.size.width, HEADER_VIEW_HEIGHT]]
  end


end
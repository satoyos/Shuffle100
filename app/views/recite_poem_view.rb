class RecitePoemView < UIView
  RP_VIEW_COLOR = UIColor.whiteColor

  PLAY_BUTTON_SIZE = 260
  PLAY_BUTTON_FONT_SIZE = PLAY_BUTTON_SIZE * 0.5
  PLAY_BUTTON_PAUSE_KEY = 'pause' # FontAwesomeのアイコン名から'fa-'を除いたもの
  PLAY_BUTTON_PLAY_KEY  = 'play'
  PLAY_BUTTON_CORNER_RADIUS = PLAY_BUTTON_SIZE / 2.0
  PLAY_MARK_INSET = PLAY_BUTTON_FONT_SIZE * 0.3
  PLAY_BUTTON_PLAYING_TITLE = FontAwesome.icon(PLAY_BUTTON_PLAY_KEY)
  PLAY_BUTTON_PAUSING_TITLE = FontAwesome.icon(PLAY_BUTTON_PAUSE_KEY)
  PLAY_BUTTON_PLAYING_COLOR = '#007bbb'.to_color # 紺碧
  PLAY_BUTTON_PAUSING_COLOR = '#e2041b'.to_color # 猩々緋

  PROGRESS_TIMER_INTERVAL = 0.1

  GEAR_BUTTON_SIZE = 30

  ACC_LABEL_PLAY_BUTTON = 'play_button'
  ACC_LABEL_TIME_SLICER = 'time_slider'
  ACC_LABEL_GEAR_BUTTON = 'gear_button'

  attr_accessor :delegate, :dataSource
#  attr_reader :play_button, :progress_bar

  def init
    super

    self.backgroundColor = UIColor.whiteColor

    self.addSubview self.play_button
    self.addSubview self.progress_bar
    self.addSubview self.gear_button

    self
  end

  def layout_with_top_offset(top_offset)
    self.frame = delegate.view.bounds
    self.play_button.layer.cornerRadius = PLAY_BUTTON_SIZE / 2
    Motion::Layout.new do |layout|
      layout.view self
      layout.subviews 'button'    => self.play_button,
                      'progress'  => self.progress_bar,
                      'gear'      => self.gear_button
      layout.metrics 'margin' => 20, 'height' => 10,
                     'b_size' => PLAY_BUTTON_SIZE,   # Playボタンのサイズは決め打ち
                     'g_size' => GEAR_BUTTON_SIZE,   # Gearボタンのサイズも決め打ち
                     'top_margin_to_gear' => top_offset + 10,
                     'top_margin_to_play' => top_offset + 50


      layout.vertical(
          '|-top_margin_to_play-[button(b_size)]-40-[progress(height)]-(<=margin@600)-|'
      )
      layout.vertical('|-top_margin_to_gear-[gear(g_size)]')
      layout.horizontal('|-(>=margin)-[button(b_size)]-(>=margin)-|')
      layout.horizontal('|-(margin)-[progress]-(margin)-|')
      layout.horizontal('[gear(g_size)]-|')

    end
  end


  def create_progress_update_timer(interval_time)
    NSTimer.scheduledTimerWithTimeInterval(interval_time,
                                           target: self,
                                           selector: 'update_progress:',
                                           userInfo: nil,
                                           repeats: true)
  end

  def update_progress(timer)
#    ap "timer(#{timer}).isValid => #{timer.isValid} in update_progress" if BW::debug?

    self.progress_bar.progress = self.delegate.current_player_progress

  end


  def show_waiting_to_pause
    show_play_button_title(PLAY_BUTTON_PAUSING_TITLE,
                           left_inset: 0,
                           color: PLAY_BUTTON_PAUSING_COLOR)
    @timer = create_progress_update_timer(PROGRESS_TIMER_INTERVAL)
  end

  def show_waiting_to_play
    ap '- 再生の指示待ちです。' if BW::debug?
    @timer.invalidate if @timer
#    ap "- @timer.isValid => #{@timer.isValid}" if BW::debug?
    show_play_button_title(PLAY_BUTTON_PLAYING_TITLE,
                           left_inset: PLAY_MARK_INSET,
                           color: PLAY_BUTTON_PLAYING_COLOR)
  end

  def play_finished_successfully
    @play_button.enabled = false
#    @time_slider.enabled = false
    @timer.invalidate
  end

  def play_button
    return @play_button if @play_button
    @play_button = UIButton.buttonWithType(UIButtonTypeCustom)
    @play_button.tap do |b|
      b.accessibilityLabel = ACC_LABEL_PLAY_BUTTON
      b.titleLabel.textAlignment = NSTextAlignmentCenter
      b.titleLabel.font = FontAwesome.fontWithSize(PLAY_BUTTON_FONT_SIZE)
      b.layer.tap do |l|
#        l.cornerRadius = PLAY_BUTTON_CORNER_RADIUS
        l.masksToBounds = true
        l.borderWidth = 1.0
        l.borderColor = UIColor.darkGrayColor.CGColor
      end
      b.addTarget(self,
                  action: :play_button_pushed,
                  forControlEvents: UIControlEventTouchUpInside)
      b.enabled = true
    end
    @play_button
  end


  def progress_bar
    @prrogress_bar ||= UIProgressView.alloc.initWithProgressViewStyle(UIProgressViewStyleDefault)

  end

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





end
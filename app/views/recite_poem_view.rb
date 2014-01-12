class RecitePoemView < UIView
  RP_VIEW_COLOR = UIColor.whiteColor

  PLAY_BUTTON_SIZE = 280
  PLAY_BUTTON_FONT_SIZE = PLAY_BUTTON_SIZE * 0.5
  PLAY_BUTTON_PAUSE_KEY = 'pause' # FontAwesomeのアイコン名から'fa-'を除いたもの
  PLAY_BUTTON_PLAY_KEY  = 'play'
  PLAY_BUTTON_CORNER_RADIUS = PLAY_BUTTON_SIZE / 2.0
  PLAY_MARK_INSET = PLAY_BUTTON_FONT_SIZE * 0.3
  PLAY_BUTTON_PLAYING_TITLE = FontAwesome.icon(PLAY_BUTTON_PLAY_KEY)
  PLAY_BUTTON_PAUSING_TITLE = FontAwesome.icon(PLAY_BUTTON_PAUSE_KEY)
  PLAY_BUTTON_PLAYING_COLOR = '#007bbb'.to_color # 紺碧
  PLAY_BUTTON_PAUSING_COLOR = '#e2041b'.to_color # 猩々緋


  ACC_LABEL_PLAY_BUTTON = 'play_button'

  attr_accessor :delegate, :dataSource, :reciting
  attr_reader :play_button

  def initWithFrame(frame)
    super

    self.backgroundColor = RP_VIEW_COLOR
    set_play_button
    self.reciting = true

    self
  end

  #%ToDo: 以下の2メソッドはまだリファクタリング可能！

  def show_play_button_pausing
    @play_button.tap do |b|
      UIEdgeInsets.new.tap do |insets|
        insets.left = 0
        b.contentEdgeInsets = insets
      end
      b.setTitle(PLAY_BUTTON_PAUSING_TITLE, forState: UIControlStateNormal)
      b.setTitleColor(PLAY_BUTTON_PAUSING_COLOR, forState: UIControlStateNormal)
      b.setTitleColor(PLAY_BUTTON_PAUSING_COLOR.colorWithAlphaComponent(0.25),
                      forState: UIControlStateHighlighted)

    end
  end

  def show_play_button_playing
    @play_button.tap do |b|
      UIEdgeInsets.new.tap do |insets|
        insets.left = PLAY_MARK_INSET
        b.contentEdgeInsets = insets
      end
      b.setTitle(PLAY_BUTTON_PLAYING_TITLE, forState: UIControlStateNormal)
      b.setTitleColor(PLAY_BUTTON_PLAYING_COLOR, forState: UIControlStateNormal)
      b.setTitleColor(PLAY_BUTTON_PLAYING_COLOR.colorWithAlphaComponent(0.25),
                      forState: UIControlStateHighlighted)
    end
  end

  private

  def set_play_button
    @play_button = UIButton.buttonWithType(UIButtonTypeCustom)
    @play_button.tap do |b|
      b.frame = play_button_frame
      b.accessibilityLabel = ACC_LABEL_PLAY_BUTTON
      b.titleLabel.font = FontAwesome.fontWithSize(PLAY_BUTTON_FONT_SIZE)
      b.titleLabel.textAlignment = NSTextAlignmentCenter
      b.layer.tap do |l|
        l.cornerRadius = PLAY_BUTTON_CORNER_RADIUS
        l.masksToBounds = true
        l.borderWidth = 1.0
        l.borderColor = UIColor.darkGrayColor.CGColor
      end
      b.addTarget(self,
                  action: :play_button_pushed,
                  forControlEvents: UIControlEventTouchUpInside)

      self.addSubview(b)
    end
    show_play_button_pausing
  end

  def play_button_frame
    [[(self.frame.size.width - PLAY_BUTTON_SIZE)/2, 150], [PLAY_BUTTON_SIZE, PLAY_BUTTON_SIZE]]
  end

  def play_button_pushed
    puts 'play_button pushed!'
    self.delegate.play_button_pushed(self, playing: self.reciting)
    self.reciting = !self.reciting
    if self.reciting
      show_play_button_pausing
    else
      show_play_button_playing
    end
  end

end
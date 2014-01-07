class RecitePoemView < UIView
  RP_VIEW_COLOR = UIColor.whiteColor

  PLAY_BUTTON_SIZE = 280
  PLAY_BUTTON_FONT_SIZE = PLAY_BUTTON_SIZE * 0.5
  PLAY_BUTTON_PAUSE_KEY = 'pause' # FontAwesomeのアイコン名から'fa-'を除いたもの
  PLAY_BUTTON_CORNER_RADIUS = PLAY_BUTTON_SIZE / 2.0

  ACC_LABEL_PLAY_BUTTON = 'play_button'

  attr_accessor :delegate, :dataSource

  def initWithFrame(frame)
    super

    self.backgroundColor = RP_VIEW_COLOR
    set_play_button

    self
  end

  private

  def set_play_button
    UIButton.buttonWithType(UIButtonTypeCustom).tap do |b|
      b.frame = play_button_frame
      b.accessibilityLabel = ACC_LABEL_PLAY_BUTTON
      b.setTitle(FontAwesome.icon(PLAY_BUTTON_PAUSE_KEY),
                 forState:UIControlStateNormal)
      b.titleLabel.font = FontAwesome.fontWithSize(PLAY_BUTTON_FONT_SIZE)
      b.titleLabel.textAlignment = NSTextAlignmentCenter
      b.setTitleColor(UIColor.redColor, forState: UIControlStateNormal)
      b.setTitleColor(UIColor.redColor.colorWithAlphaComponent(0.25),
                      forState: UIControlStateHighlighted)

      b.layer.tap do |l|
        l.cornerRadius = PLAY_BUTTON_CORNER_RADIUS
        l.masksToBounds = true
        l.borderWidth = 1.0
        l.borderColor = UIColor.darkGrayColor.CGColor
      end

      self.addSubview(b)
    end
  end

  def play_button_frame
    [[(self.frame.size.width - PLAY_BUTTON_SIZE)/2, 150], [PLAY_BUTTON_SIZE, PLAY_BUTTON_SIZE]]
  end
end
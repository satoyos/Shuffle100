class RecitePoemLayout < MotionKit::Layout
  include RecitePoemStyles

  PROGRESS_TIMER_INTERVAL = 0.01
  GOLDEN_RATIO = 1.618
  OPENING_POEM_TITLE = '序歌'

  attr_accessor :sizes
  weak_attr :delegate

  def layout
    background_color UIColor.whiteColor

    # header area
    add UIView, :header_container do
      add UILabel, :header_title do
        text OPENING_POEM_TITLE
      end
      add BarGearButton, :gear_button
      add BarExitButton, :quit_button
    end

    # play_button
    add ReciteViewButton, :play_button

    # progress_bar and skip_buttons
    add UIView, :lower_container do
      add UIProgressView, :progress_bar
      add ReciteViewButton, :rewind_button
      add ReciteViewButton, :forward_button
    end

    add UILabel, :notice_label
  end

  def show_waiting_to_pause
    show_play_button_title(PLAY_BUTTON_PAUSING_TITLE,
                           left_inset: 0,
                           color: PLAY_BUTTON_PAUSING_COLOR)
    play_button.titleLabel.accessibilityLabel = ACC_LABEL_PAUSE
    @timer = create_progress_update_timer(PROGRESS_TIMER_INTERVAL)
  end

  def show_waiting_to_play
    ap '- 再生の指示待ちです。' if BW2.debug?
    @timer.invalidate if @timer
    show_play_button_title(PLAY_BUTTON_PLAYING_TITLE,
                           left_inset: play_mark_inset,
                           color: PLAY_BUTTON_PLAYING_COLOR)
    play_button.titleLabel.accessibilityLabel = ACC_LABEL_PLAY
  end

  def play_finished_successfully
    @timer.invalidate if @timer and @timer.isValid
  end

  def locate_view(side)
    case side
      when :right
        view.frame = [[view.frame.size.width, view.frame.origin.y], view.frame.size]
      when :left
        view.frame = [[-1 * view.frame.size.width, view.frame.origin.y], view.frame.size]
      when :normal
        view.frame = [[0, view.frame.origin.y], view.frame.size]
      else
        # 何もしない
    end
  end

  def title_text
    get(:header_title).text
  end

  def title=(title)
    get(:header_title).text = title
  end

  def update_progress
    progress_bar.progress = delegate.current_player_progress if delegate
  end

  def font_changed(notification)
    get(:header_title).font = MDT::Font.body
  end

  NOTICE_ANIMATE_DURATION = 2.0

  def show_opening_notice_if_needed
    return unless self.title_text == OPENING_POEM_TITLE
    UIView.animation_chain(duration: NOTICE_ANIMATE_DURATION) do
      get(:notice_label).fade_in
    end.and_then(duration: NOTICE_ANIMATE_DURATION * GOLDEN_RATIO) do
      get(:notice_label).fade_out
    end.start
  end

  class << self
    def create_with_delegate(delegate, sizes: sizes)
      self.new.tap{|l|
        l.delegate = delegate
        l.sizes = sizes
      }.build
    end
  end

  private

  def show_play_button_title(title, left_inset: l_inset, color: color)
    play_button.tap do |b|
      UIEdgeInsets.new.tap do |insets|
        insets.left = l_inset
        b.contentEdgeInsets = insets
      end
      b.setTitle(title, forState: UIControlStateNormal)
      b.setTitleColor(color, forState: UIControlStateNormal)
      b.setTitleColor(color.colorWithAlphaComponent(0.25),
                      forState: UIControlStateHighlighted | UIControlStateDisabled)
      b.accessibilityLabel = case title
                               when PLAY_BUTTON_PAUSING_TITLE ; ACC_LABEL_PAUSE
                               else ; ACC_LABEL_PLAY
                             end
    end
  end

  def play_button
    @play_button ||= get(:play_button)
  end

  def progress_bar
    @progress_bar ||= get(:progress_bar)
  end

  def create_progress_update_timer(interval_time)
    NSTimer.scheduledTimerWithTimeInterval(interval_time,
                                           target: self,
                                           selector: 'update_progress',
                                           userInfo: nil,
                                           repeats: true)
  end

end
class RecitePoemLayout < MotionKit::Layout
  include RecitePoemStyles

  PROGRESS_TIMER_INTERVAL = 0.1

  weak_attr :delegate

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

      # progress_bar and skip_buttons
      add UIView, :lower_container do
        add UIProgressView, :progress_bar
        add ReciteViewButton, :rewind_button
        add ReciteViewButton, :forward_button
      end
    end

  end

  def show_waiting_to_pause
    show_play_button_title(PLAY_BUTTON_PAUSING_TITLE,
                           left_inset: 0,
                           color: PLAY_BUTTON_PAUSING_COLOR)
    play_button.titleLabel.accessibilityLabel = ACC_LABEL_PAUSE
    @timer = create_progress_update_timer(PROGRESS_TIMER_INTERVAL)
  end

  def show_waiting_to_play
    ap '- 再生の指示待ちです。' if BW::debug?
    @timer.invalidate if @timer
    show_play_button_title(PLAY_BUTTON_PLAYING_TITLE,
                           left_inset: PLAY_MARK_INSET,
                           color: PLAY_BUTTON_PLAYING_COLOR)
    play_button.titleLabel.accessibilityLabel = ACC_LABEL_PLAY
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

  def update_progress
    progress_bar.progress = delegate.current_player_progress if delegate
  end

  ###############
  # Class Methods
  ###############

  class << self
    def gear_image
      @gear_image ||= header_button_from_image_file('gear-520.png')
    end

    def exit_image
      @exit_image ||= header_button_from_image_file('exit_square_org.png')
    end

    private

    def header_button_from_image_file(file_path)
      ResizeUIImage.resizeImage(UIImage.imageNamed(file_path),
                                newSize: RecitePoemStyles::BUTTON_IMAGE_SIZE).
          imageWithRenderingMode(UIImageRenderingModeAlwaysTemplate)
    end
  end

end
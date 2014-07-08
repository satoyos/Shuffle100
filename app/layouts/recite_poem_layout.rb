class RecitePoemLayout < MotionKit::Layout
  include RecitePoemStyles

=begin
  STATUS_BAR_HEIGHT = 20 # これはシステムのステータスバーの値そのまま。好きに変えていいわけではない。
  HEADER_HEIGHT = 40
  HEADER_BUTTON_SIZE = 25
  HEADER_BUTTON_MARGIN = 10
  BUTTON_IMAGE_SIZE = CGSizeMake(HEADER_BUTTON_SIZE, HEADER_BUTTON_SIZE)
=end


  # PLAY_BUTTON_SIZE = 260
  # PLAY_BUTTON_FONT_SIZE = PLAY_BUTTON_SIZE * 0.5
  # PLAY_BUTTON_PLAYING_TITLE = FontAwesome.icon('play')
  # PLAY_BUTTON_PAUSING_TITLE = FontAwesome.icon('pause')
  # PLAY_BUTTON_PLAYING_COLOR = '#007bbb'.to_color # 紺碧
  # PLAY_BUTTON_PAUSING_COLOR = '#e2041b'.to_color # 猩々緋

=begin
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
=end


  # weak_attr :delegate

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


=begin
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
=end

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
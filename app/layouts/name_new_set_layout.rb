class NameNewSetLayout < MotionKit::Layout
  def layout
    background_color :white.uicolor



=begin
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
=end
  end

end
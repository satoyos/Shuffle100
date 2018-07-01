class NameNewSetLayout < MotionKit::Layout
  def layout
    background_color :white.uicolor


    add UITextField, :name_field

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

  def name_field_style
    size ['80%', '5%']
    center ['50%', '30%']
    text_alignment UITextAlignmentCenter
    placeholder '名前を決めてください'
    accessiblility_label 'name_field'
  end

end
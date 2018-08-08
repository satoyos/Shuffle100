class NameNewSetLayout < MotionKit::Layout
  include NormalButtonStyles

  def layout
    background_color :white.uicolor


    add UITextField, :name_field
    add UIView, :buttons_container do
      add UIButton, :fix_button
      add UIButton, :cancel_button

    end
  end

  def name_field_style
    size ['80%', '5%']
    center ['50%', '30%']
    text_alignment UITextAlignmentCenter
    placeholder '名前を決めてください'
    accessibility_label 'name_field'
  end

  def buttons_container_style
    size ['80%', '10%']
    center ['50%', '40%']
  end

  def fix_button_style
    set_button_title_color
    size ['40%', '80%']
    center ['75%', '50%']
    title '決定'
    accessibility_label 'fix_button'
  end

  def cancel_button_style
    set_button_title_color
    size ['40%', '80%']
    center ['25%', '50%']
    title 'キャンセル'
    accessibility_label 'cancel_button'
  end
end
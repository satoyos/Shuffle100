class BDAreaLayout < MotionKit::Layout

  weak_attr :delegate

  def layout
    root :root_view do
      add UIButton, :bd_beg_on_button
      add UIButton, :bd_beg_off_button
    end
  end

  def root_view_style
    background_color 'blue'.uicolor
  end

  def bd_beg_on_button_style
    size [10, 10]
    center ['10%', '50%']
    title '初心者モードon'
  end

  def bd_beg_off_button_style
    size [10, 10]
    center ['90%', '50%']
    title '初心者モードoff'
  end
end
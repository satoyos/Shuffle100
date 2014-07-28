class BDAreaLayout < MotionKit::Layout

  weak_attr :delegate

  def layout
    root :root_view do

    end
  end

  def root_view_style
    background_color 'blue'.to_color
  end
end
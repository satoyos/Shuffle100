class FudaLayout < MK::Layout
  BASE_BACK_COLOR = 0xdddddd.uicolor(0.9)

  attr_accessor :top_guide, :bottom_guide

  def layout
    root(:root) do
      add UIButton, :close_button
      add FudaView, :fuda_view
    end
  end

  def root_style
    background_color BASE_BACK_COLOR
    accessibility_label 'FudaLayoutView'
    height = self.view.frame.size.height
    width = self.view.frame.size.width
    if top_guide
      origin [0, 0]
      size [width, height + bottom_guide.origin.y + 20]
    end
  end

  def close_button_style
    title '閉じる'
    title_color :blue.uicolor
    size_to_fit
    frame from_top_right(down: 10, left: 5)
  end

  def fuda_view_style
    init_with_string 'あっちょんぶりけ'
    set_all_sizes_by 300
    center ['50%', '50%']
  end
end
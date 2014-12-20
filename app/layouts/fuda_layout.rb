class FudaLayout < MK::Layout
  include NormalButtonStyles

  BASE_BACK_COLOR = 'tatami_moved.jpg'.uicolor

  # attr_accessor :view_size, :view_origin, :shimo_str
  attr_accessor :view_frame, :shimo_str

  def layout
    root(:root) do
      add UIButton, :close_button
      add FudaView, :fuda_view
    end
  end

  def root_style
    background_color BASE_BACK_COLOR
    accessibility_label 'FudaLayoutView'
=begin
    if view_size
      origin [view_origin.x, view_origin.y]
      size [view_size.width, view_size.height]
    end
=end
    frame view_frame if view_frame
  end

  def close_button_style
    title '閉じる'
    set_button_title_color
    background_color :white.uicolor(0.4)
    layer do
      corner_radius 3.0
    end
    size_to_fit
    frame from_top_right(down: 10, left: 10)
  end

  def fuda_view_style
    init_with_string shimo_str || 'あっちょんぶりけ'
    height = fuda_height_on_me(2.to_f/3)
    puts "-- 計算された高さは [#{height}]" if BW2.debug?
    set_all_sizes_by height
    center ['50%', '50%']
  end

  class << self
    def create_with_frame(frame, str: shimo_str)
      self.new.tap do |l|
        l.view_frame = frame
        l.shimo_str = shimo_str
      end
    end
  end

  private

  def fuda_height_on_me(ratio)
    return 300 unless view_frame
    [view_frame.size.height * ratio,
        view_frame.size.width * ratio / FudaView::FUDA_SIZE_IN_MM.width * FudaView::FUDA_SIZE_IN_MM.height].min
  end

end
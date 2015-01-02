class FudaLayout < MK::Layout
  include NormalButtonStyles

  BASE_BACK_COLOR = 'tatami_moved.jpg'.uicolor

  attr_accessor :shimo_str, :top_offset

  def initialize
    super
    @top_offset = 0
  end

  def layout
    background_color BASE_BACK_COLOR
    accessibility_label 'FudaLayoutView'
    add FudaView, :fuda_view
  end

  def fuda_view_style
    init_with_string shimo_str || 'あっちょんぶりけ'
    height = fuda_height_on_me(2.to_f/3)
    puts "-- 計算された高さは [#{height}]" if BW2.debug?
    set_all_sizes_by height
    center ['50%', "50% + #{top_offset / 2}"]
  end

  private

  def fuda_height_on_me(ratio)
    return 300 unless top_offset
    [(view.frame.size.height - top_offset) * ratio,
        view.frame.size.width * ratio / FudaView::FUDA_SIZE_IN_MM.width * FudaView::FUDA_SIZE_IN_MM.height].min
  end

end
module LayoutGuideHelper
  def puts_info_about_layout_guide
    puts "iOS Version => #{BW2.ios_version}"
    puts '+ TopLayoutGuide => '
    ap topLayoutGuide
    puts '+ BottomLayoutGuide => '
    ap bottomLayoutGuide
  end

  def top_guide_height
    topLayoutGuide.size.height
  end
end
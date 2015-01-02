class FudaScreen < PM::Screen
  include LayoutGuideHelper

  attr_reader :layout
  attr_accessor :fuda_str

  def on_load
    puts "nav_bar_offset => #{nav_bar_offset}"
    @layout = FudaLayout.new.tap {|l|
      l.top_offset = nav_bar_offset
      l.shimo_str = fuda_str || 'あかさたなはまやらわ'
    }
    self.view = layout.view
  end

  private

  def nav_bar_offset
    case navigationController
      when nil ; 0
      else
        print_about_nav_bar if BW2.debug?
        nav_bar_frame.size.height + 30
        # ↑ iOS7とiOS8でnav_bar.origin.yが取得できたりできなかったりするので、いっそ固定値で。
    end
  end

  def print_about_nav_bar
    puts '** navigationBar => '
    ap navigationController.navigationBar
    puts '*** navigationBar.backgroudImage => '
    ap navigationController.navigationBar.subviews.first
  end

  def nav_bar_frame
    navigationController.navigationBar
  end

end
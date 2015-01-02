class FudaScreen < PM::Screen
  include LayoutGuideHelper

  attr_reader :layout
  attr_accessor :fuda_str, :nav_bar_title

  def on_load
    puts "nav_bar_offset => #{nav_bar_offset}" if BW2.debug?
    puts "nav_bar_title  => #{nav_bar_title}" if BW2.debug?
    self.title = nav_bar_title if nav_bar_title
    @layout = FudaLayout.new.tap {|l|
      l.top_offset = nav_bar_offset
      l.shimo_str = fuda_str || 'あかさたなはまやらわ'
    }
    self.view = layout.view
    set_nav_bar_buttons
  end

  def should_autorotate
    false
  end

  private

  def set_nav_bar_buttons
    set_nav_bar_button :right, {title: '閉じる', action: :close}
  end

  def nav_bar_offset
    case navigationController
      when nil ; 0
      else
        print_about_nav_bar if BW2.debug?
        nav_bar.size.height + 30
        # ↑ iOS7とiOS8でnav_bar.origin.yが取得できたりできなかったりするので、いっそ固定値で。
    end
  end

  def print_about_nav_bar
    puts '** navigationBar => '
    ap nav_bar
    puts '*** navigationBar.backgroudImage => '
    ap nav_bar.subviews.first
  end

  def nav_bar
    navigationController.navigationBar
  end

end
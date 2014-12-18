class WhatsNextScreen < PM::Screen
  include GameQuitDelegate

  title '次はどうする？'

  BAR_BUTTON_SIZE = 28

  attr_reader :layout

  def on_load
    @layout = WhatsNextLayout.new.tap{|l|
      l.sizes = app_delegate.sizes ? app_delegate.sizes :
          OH::DeviceSizeManager.select_sizes  # こっちはRSpecテスト用。
    }
    self.view = layout.view
    set_navigation_bar_buttons
    set_button_actions
  end

  def on_appear
    fetch_frame_for_fuda_layout unless self.class.fuda_layout_size
  end

  class << self
    attr_accessor :fuda_layout_size, :fuda_layout_origin
  end

  private

  def set_navigation_bar_buttons
    set_nav_bar_button :right, {
        button: @exit_button =
            BarExitButton.create_with_square_size(BAR_BUTTON_SIZE)
    }
    set_nav_bar_button :left, {
        button: @gear_button =
            BarGearButton.create_with_square_size(BAR_BUTTON_SIZE)
    }
  end

  def set_button_actions
    layout.get(:refrain_button).on(:touch){
      puts '+ 「もう1回下の句」ボタンが押された！' if BW2.debug?
      close(next: :refrain)
    }
    layout.get(:next_poem_button).on(:touch){
      puts '+ 「次の歌へ！」ボタンが押された！' if BW2.debug?
      close(next: :next_poem)
    }
    layout.get(:torifuda_button).on(:touch){
      puts '+ 「取り札を見る」ボタンが押された！' if BW2.debug?
      show_torifuda
    }
    @gear_button.on(:touch){
      puts '+ 「いろいろな設定」ボタンが押された！' if BW2.debug?
      open_on_game_settings
    }
    @exit_button.on(:touch){
      puts '+ 終了ボタンが押された！' if BW2.debug?
      confirm_user_to_quit
    }
  end

  def open_on_game_settings
    open OnGameSettingsScreen.new, modal: true, nav_bar: true
  end

  def back_to_top_screen
    close(next: :back_to_top)
  end

  def show_torifuda
    FudaLayout.new.tap{ |l|
      l.view_size = self.class.fuda_layout_size
      l.view_origin = self.class.fuda_layout_origin
      l.shimo_str = parent_screen.supplier.poem.in_hiragana.shimo
      l.view.tap do |v|
        v.alpha = 0
        add v
        v.fade_in(duration: 0.1)
      end
      l.get(:close_button).on(:touch){
        l.view.fade_out do
          l.view.removeFromSuperview
        end
      }
    }
  end

  def fetch_frame_for_fuda_layout
    if BW2.debug?
      puts "iOS Version => #{BW2.ios_version}"
      puts '+ TopLayoutGuide => '
      ap topLayoutGuide
      puts '+ BottomLayoutGuide => '
      ap bottomLayoutGuide
    end
    self.class.fuda_layout_origin =
        CGPointMake(topLayoutGuide.size.width, top_layout_guide_height)
    self.class.fuda_layout_size =
        CGSizeMake(frame.size.width,
                   frame.size.height - top_layout_guide_height)
  end

  def top_layout_guide_height
    topLayoutGuide.size.height
  end
end
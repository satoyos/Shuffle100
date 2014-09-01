class HomeScreen < PM::GroupedTableScreen
  include SelectedStatusHandler
  include HomeScreenDataSource
  include HomeScreenDelegate
  title 'トップ'

  SELECT_POEM_TITLE = '取り札を用意する歌'
  NAV_BAR_BUTTON_SIZE = CGSizeMake(14, 14)

  def on_load
    set_nav_bar_button :right, {
        image: self.class.help_image,
        action: :open_info
    }
    set_nav_bar_button :left, {
        image: self.class.gear_image,
        action: :open_on_game_settings
    }
  end

  def will_appear
    navigation_controller.setNavigationBarHidden(false, animated: false) if self.nav_bar?
    self.navigationItem.prompt = '百首読み上げ'
    update_table_data
    set_bd_layout if BW2.debug?
  end

  def on_appear
    @beg_switch = view.subviews.first.subviews.find{|cell| cell.textLabel.text =~ /初心者/}.accessoryView unless
        view.subviews.first.subviews.empty?
  end

  def should_autorotate
    false
  end

  def supported_orientations
    UIInterfaceOrientationPortrait
  end

  def self.help_image
    Dispatch.once{@info_iamge =
        ResizeUIImage.resizeImage(UIImage.imageNamed('question_white.png'),
                                  newSize: NAV_BAR_BUTTON_SIZE).tap do |im|
          im.accessibilityLabel = 'help'
        end
    }
    @info_iamge
  end

  def self.gear_image
    Dispatch.once{@gear_iamge =
        ResizeUIImage.resizeImage(UIImage.imageNamed('gear-520.png'),
                                  newSize: NAV_BAR_BUTTON_SIZE).tap do |im|
          im.accessibilityLabel = 'gear'
        end
    }
    @gear_iamge
  end


end

def set_bd_layout
  @bd_view = UIView.alloc.initWithFrame([[0, 300], [30, 20]])
  add @bd_view
  bd_layout = BDAreaLayout.new(root: @bd_view).tap { |layout| layout.delegate = self }.build
  bd_layout.tap do |l|
    l.get(:bd_beg_on_button).addTarget(self, action: 'beg_button_pushed', forControlEvents: UIControlEventTouchUpInside)
    l.get(:bd_beg_off_button).addTarget(self, action: 'beg_off_button_pushed', forControlEvents: UIControlEventTouchUpInside)
  end
end


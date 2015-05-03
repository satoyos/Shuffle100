class HomeScreen < PM::GroupedTableScreen
  include SelectedStatusHandler
  include HomeScreenDataSource
  include HomeScreenDelegate
  title 'トップ'

  SELECT_POEM_TITLE = '取り札を用意する歌'
  NAV_BAR_BUTTON_SIZE = CGSizeMake(14, 14)
  BAR_BUTTON_SIZE = 28

  def on_load
    set_nav_bar_button :right, {
        button: @help_button =
            BarHelpButton.create_with_square_size(BAR_BUTTON_SIZE)
    }
    set_nav_bar_button :left, {
        button: @gear_button =
            BarGearButton.create_with_square_size(BAR_BUTTON_SIZE)
    }
    set_nav_bar_button_actions
  end

  def will_appear
    navigation_controller.tap do |nc|
      nc.setNavigationBarHidden(false, animated: false)
      nc.navigationBar.translucent = false
    end if self.nav_bar?
    self.navigationItem.prompt = app_delegate.prompt
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

  private

  def set_nav_bar_button_actions
    @gear_button.on(:touch){open_on_game_settings}
    @help_button.on(:touch){open_help}
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
end

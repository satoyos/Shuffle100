class HomeScreen < PM::GroupedTableScreen
  include SelectedStatusHandler
  include HomeScreenDataSource
  include HomeScreenDelegate
  title 'トップ'

  SELECT_POEM_TITLE = '取り札を用意する歌'
  NAV_BAR_BUTTON_SIZE = CGSizeMake(14, 14)
  # BAR_BUTTON_SIZE = 28
  BAR_BUTTON_SIZE = 14

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
      if BW2.debug?
        fr = navigation_controller.navigationBar.frame
        puts "●ナビゲーションバーのframe => [orgX: #{fr.origin.x}, orgY: #{fr.origin.y}, width: #{fr.size.width}, height: #{fr.size.height}]"
      end
    end if self.nav_bar?
    self.navigationItem.prompt = app_delegate.prompt
    update_table_data
  end

  def on_appear
    allow_sleeping
  end

  def should_autorotate
    false
  end

  private

  def set_nav_bar_button_actions
    @gear_button.on(:touch){open_on_game_settings}
    @help_button.on(:touch){open_help}
  end

  def prohibit_sleeping
    puts 'xxx 寝たらあかんで！(￣ー￣)' if BW2.debug?
    UIApplication.sharedApplication.idleTimerDisabled = true
  end

  def allow_sleeping
    puts 'ooo 寝てもええんやで。ヽ(´ー`)ノ`' if BW2.debug?
    UIApplication.sharedApplication.idleTimerDisabled = false
  end
end

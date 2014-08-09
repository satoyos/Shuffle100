class HomeScreen < PM::GroupedTableScreen
  include SelectedStatusHandler
  include HomeScreenDataSource
  include HomeScreenDelegate
  title 'トップ'

  FAKE_SETTING_TITLE = '空札を加える'
  INFO_BUTTON_SIZE = CGSizeMake(16, 16)
  ACC_LABEL_INFO_BUTTON = 'Info'

=begin
  def table_data
    [
        {
            title: '設定',
            title_view_height: 30,
            cells: game_setting_cells
        },
        {
            title: '試合開始',
            cells: [start_game_cell]
        }
    ]
  end
=end

  def on_load
    set_nav_bar_button :right, {
        image: info_image,
        action: :open_info
    }
  end

  def will_appear
    navigation_controller.setNavigationBarHidden(false, animated: false) if self.nav_bar?
    self.navigationItem.prompt = '百首読み上げ'
    update_table_data
    set_bd_layout
  end

  def on_appear
    @beg_switch = view.subviews.first.subviews.find{|cell| cell.textLabel.text =~ /初心者/}.accessoryView unless
        view.subviews.first.subviews.empty?
    # puts "@beg_switch => #{@beg_switch}, value: #{@beg_switch.on?}" if BW2.debug?
  end

  def should_autorotate
    false
  end

  def supported_orientations
    UIInterfaceOrientationPortrait
  end

  private

  def info_image
    ResizeUIImage.resizeImage(UIImage.imageNamed('info_white.png'),
                              newSize: INFO_BUTTON_SIZE).tap do |im|
      im.accessibilityLabel = 'info'
    end
  end


  # @return [Deck] 選択された歌から構成されるDeck。歌の順序はShuffleされている。
  def selected_poems_deck
    Deck.create_from_bool100(loaded_selected_status.status_array).shuffle!
  end

  def game_setting_cells
    cells = [
        select_poems_cell,
        beginner_mode_switch_cell,
    ]
    cells << fake_mode_switch_cell unless app_delegate.game_settings.beginner_flg
    cells
  end

  def select_poems_cell
    {
        title: SELECT_POEM_TITLE,
        cell_style: UITableViewCellStyleValue1,
        subtitle: '%d首' % loaded_selected_status.selected_num,
        action: :select_poems,
        accessoryType: UITableViewCellAccessoryDisclosureIndicator,
        accessibilityLabel: 'select_poem',
    }
  end

  def beginner_mode_switch_cell
    {
        title: '初心者モード(散らし取り)',
        accessory: {
            view: :switch,
            value: app_delegate.game_settings.beginner_flg,
            action: 'beginner_switch_flipped:',
            accessibilityLabel: 'beginner_switch'
        }
    }
  end

  def fake_mode_switch_cell
    {
        title: FAKE_SETTING_TITLE,
        accessory: {
            view: :switch,
            value: app_delegate.game_settings.fake_flg,
            action: 'fake_switch_flipped:',
            accessibilityLabel: 'fake_switch'
        }
    }
  end

  def start_game_cell
    {
        title: '試合開始',
        action: :start_game,
        cell_class: GameStartCell,
    }
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


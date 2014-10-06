class HelpMenuScreen < PM::TableScreen
  title 'ヘルプ'

  def table_data
    [{
        cells:
            [
                {
                    title: '「初心者モード」とは？',
                    action: :open_what_is_beginner_mode,
                    style: {
                        accessoryType: UITableViewCellAccessoryDisclosureIndicator,
                        # accessibility_label: 'open_game_flow_help'
                    }
                },
                {
                    title: '試合の流れ (通常モード)',
                    action: :open_game_flow_help,
                    style: {
                        accessoryType: UITableViewCellAccessoryDisclosureIndicator,
                        # accessibility_label: 'open_game_flow_help'
                    }
                },
                {
                    title: '試合の流れ (初心者モード)',
                    action: :open_beginner_mode_flow_help,
                    style: {
                        accessoryType: UITableViewCellAccessoryDisclosureIndicator,
                        # accessibility_label: 'open_game_flow_help'
                    }
                },
                {
                    title: '設定できること',
                    action: :open_options_help,
                    style: {
                        accessoryType: UITableViewCellAccessoryDisclosureIndicator,
                        # accessibility_label: 'open_options_help'
                    }
                },
                {
                    title: 'バージョン',
                    cell_style: UITableViewCellStyleValue1,
                    subtitle: "#{'CFBundleShortVersionString'.info_plist}"
                }
            ]
     }]
  end

  def will_appear
    navigationItem.prompt = '百首読み上げ'
  end

  def should_autorotate
    false
  end

  def open_what_is_beginner_mode
    open InfoScreen.new(url: 'html/what_is_beginner_mode.html', title: '「初心者モード」とは？')
  end

  def open_options_help
    open InfoScreen.new(url: 'html/options.html', title: '設定できること')
  end

  def open_game_flow_help
    open InfoScreen.new(url: 'html/game_flow.html', title: '試合の流れ (通常モード)')
  end

  def open_beginner_mode_flow_help
    open InfoScreen.new(url: 'html/beginner_mode_flow.html', title: '試合の流れ (初心者モード)')
  end


end
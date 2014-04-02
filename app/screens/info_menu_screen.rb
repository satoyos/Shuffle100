class InfoMenuScreen < PM::TableScreen
  title 'Info.'

  def table_data
    [{
        cells:
            [
                {
                    title: '設定できること',
                    action: :open_options_help,
                    accessibility_label: 'open_options_help'
                },
                {
                    title: '試合の流れ',
                    action: :open_game_flow_help,
                    accessibility_label: 'open_game_flow_help'
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

  def open_options_help
#    open SettingsHelpScreen.new
    open InfoScreen.new(url: 'html/options.html', title: '設定できること')
  end

  def open_game_flow_help
#    open GameFlowHelpScreen.new
    open InfoScreen.new(url: 'html/game_flow.html', title: '試合の流れ')
  end
end
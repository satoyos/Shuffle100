class InfoScreen < PM::TableScreen
  title 'Info.'

  def table_data
    [{
        cells:
            [
                {
                    title: '設定できること',
                    action: :open_settings_help
                },
                {
                    title: '試合の流れ',
                    action: :open_game_flow_help
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

  def open_settings_help
    open SettingsHelpScreen.new
  end

  def open_game_flow_help
    open GameFlowHelpScreen.new
  end
end
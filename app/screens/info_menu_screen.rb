class InfoMenuScreen < PM::TableScreen
  title 'ヘルプ'

  def table_data
    [{
        cells:
            [
                {
                    title: '試合の流れ',
                    action: :open_game_flow_help,
                    accessibility_label: 'open_game_flow_help'
                },
                {
                    title: '設定できること',
                    action: :open_options_help,
                    accessibility_label: 'open_options_help'
                },
                {
                    title: 'バージョン',
                    cell_style: UITableViewCellStyleValue1,
                    subtitle: "#{App.version}"
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
    open InfoScreen.new(url: 'html/options.html', title: '設定できること')
  end

  def open_game_flow_help
    open InfoScreen.new(url: 'html/game_flow.html', title: '試合の流れ')
  end
end
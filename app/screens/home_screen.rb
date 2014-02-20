class HomeScreen < PM::GroupedTableScreen
  title '百首読み上げ'

  def table_data
    [
        {
            title: "設定",
            title_view_height: 30,
            cells: [
                {
                    title: 'title1'
                },
                {
                    title: 'title2'
                },
                {
                    title: 'title3'
                }
            ]
        },
        {
            title: '試合開始',
            cells: [{title: '試合開始',
                     action: :start_game,
                     cell_class: GameStartCell,
                    }]
        }
    ]
  end

  def start_game
    puts '++ 試合開始！' if BW::debug?
#    app_delegate.class.status_bar false, animation: :fade
#    UIApplication.sharedApplication.setStatusBarHidden(true, animated: false)
    navigation_controller.setNavigationBarHidden(true, animated: true)
    open RecitePoemScreen.new
  end
end
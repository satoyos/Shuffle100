module HomeScreenDataSource
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

end
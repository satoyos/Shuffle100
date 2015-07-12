module HelpMenuScreenDataSource
  def table_data
    [{
         title: '使い方',
         title_view_height: 40,
         cells: how_to_use_cells
     },
     {
         title: 'その他',
         title_view_height: 40,
         cells: other_info_cells
     }]
  end

  private

  def how_to_use_cells
    [
        {
            title: '設定できること',
            action: :open_options_help,
            style: {
                accessoryType: UITableViewCellAccessoryDisclosureIndicator,
            }
        },
        {
            title: '試合の流れ (通常モード)',
            action: :open_game_flow_help,
            style: {
                accessoryType: UITableViewCellAccessoryDisclosureIndicator,
            }
        },
        {
            title: '「初心者モード」とは？',
            action: :open_what_is_beginner_mode,
            style: {
                accessoryType: UITableViewCellAccessoryDisclosureIndicator,
            }
        },
        {
            title: '試合の流れ (初心者モード)',
            action: :open_beginner_mode_flow_help,
            style: {
                accessoryType: UITableViewCellAccessoryDisclosureIndicator,
            }
        }
    ]
  end

  def other_info_cells
    [
        {
            title: '「いなばくん」について',
            action: :open_about_inaba_kun,
            style: {
                accessoryType: UITableViewCellAccessoryDisclosureIndicator,
            }
        },
        {
            title: 'このアプリを評価する',
            action: :confirm_user_to_review,
            style: {
                accessoryType: UITableViewCellAccessoryDisclosureIndicator,
            }
        },
        {
            title: 'バージョン',
            cell_style: UITableViewCellStyleValue1,
            subtitle: "#{'CFBundleShortVersionString'.info_plist}"
        }
    ]
  end
end
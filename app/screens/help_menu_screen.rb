# coding: utf-8
class HelpMenuScreen < PM::TableScreen
  title 'ヘルプ'

  def table_data
    [{
       title: '使い方',
#       title_view_height: 40,  
       cells:
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
     },
     {
       title: 'その他',
#       title_view_height: 40,
       cells:
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

  def open_about_inaba_kun
    open InfoScreen.new(url: 'html/about_inaba_kun.html', title: '「いなばくん」とは？')
  end

  def review_page_url
    'itms-apps://itunes.apple.com/app/id' + 'AppStoreID'.info_plist
  end

  def confirm_user_to_review
    UIAlertView.alert('このアプリを評価するために、App Storeアプリを立ち上げますか？',
                      buttons: ['立ち上げる', 'やめておく']
    ) do |button, button_index|
      if button == '立ち上げる'
        puts '[move] App Storeアプリに遷移します' if BW2.debug?
        open_review_page
      else
        puts '[cancel] 評価は行いません' if BW2.debug?
      end
    end
  end

  private

  def open_review_page
    app.openURL(review_page_url.nsurl)
  end
end

# coding: utf-8
class HelpMenuScreen < PM::GroupedTableScreen
  include HelpMenuScreenDataSource

  title 'ヘルプ'

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

  def open_what_is_nonstop_mode
    open InfoScreen.new(url: 'html/what_is_nonstop_mode.html', title: 'ノンストップ・モードとは？')
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

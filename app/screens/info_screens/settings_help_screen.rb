class SettingsHelpScreen < PM::WebScreen
  title '設定できること'

  def content
    'html/options.html'
  end

  def will_appear
    navigationItem.prompt = '百首読み上げ'
  end

  def should_autorotate
    false
  end
end
class GameFlowHelpScreen < PM::WebScreen
  title '試合の流れ'

  def content
    'html/game_flow.html'
  end

  def will_appear
    navigationItem.prompt = '百首読み上げ'
  end

  def should_autorotate
    false
  end
end
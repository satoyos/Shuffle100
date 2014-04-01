class InfoScreen < PM::TableScreen
  title 'ヘルプなど'

  def table_data
    []
  end

  def will_appear
    navigationItem.prompt = '百首読み上げ'
  end

  def should_autorotate
    false
  end
end
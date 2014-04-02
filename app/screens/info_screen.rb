class InfoScreen < PM::WebScreen
  attr_accessor :url

  def content
    self.url
  end

  def will_appear
    navigationItem.prompt = '百首読み上げ'
  end

  def should_autorotate
    false
  end
end
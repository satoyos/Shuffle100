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

  def webView(webView, shouldStartLoadWithRequest: request, navigationType: navigationType)
    if navigationType == UIWebViewNavigationTypeLinkClicked ||
        navigationType == UIWebViewNavigationTypeOther
      url = request.URL.absoluteString
      puts "[[[ REQUEST URL]]] => #{url}" if BW2.debug?

      unless url =~ /\Afile/ or url =~ /vimeo.com\// or url =~ /itunes.apple.com/ or url =~ /vimeocdn.com\//
        puts  "- URL stopped! (#{url})" if BW2.debug?
        return false
      end
    end

    true
  end
end
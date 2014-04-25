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
    if (navigationType == UIWebViewNavigationTypeLinkClicked ||
        navigationType == UIWebViewNavigationTypeOther)
      url = request.URL.absoluteString
      unless url =~ /\Afile/ or url =~ /vimeo.com\//
        puts  "- URL stopped! (#{url})" if BW::debug?
        return false
      end
    end

    true
  end
end
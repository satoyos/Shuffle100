module OneHundred
  module Notifications
    module_function

    def set_font_changed_notification
      NSNotificationCenter.defaultCenter.addObserver(
          self,
          selector: 'font_changed:',
          name: UIContentSizeCategoryDidChangeNotification,
          object: nil
      )
    end
  end
end

OH = OneHundred unless defined?(OH)
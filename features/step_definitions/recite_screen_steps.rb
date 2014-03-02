require 'cgi'

def mark_waiting_play
  'play'
end

def mark_waiting_pause
  'pause'
end

Then /^I should see play_button waiting "([^\"]*)"$/ do |expedted_mark|

  quote = get_selector_quote(expedted_mark)
  check_element_exists("label marked:#{quote}#{expedted_mark}#{quote}")
end

Then /^I should not see play_button waiting "([^\"]*)"$/ do |expedted_mark|

  quote = get_selector_quote(expedted_mark)
  check_element_does_not_exist_or_is_not_visible("label marked:#{quote}#{expedted_mark}#{quote}")
end

Then /^I should see an alert view$/ do
  check_element_exists( 'alertView' )
end


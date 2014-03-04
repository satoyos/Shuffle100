# coding: utf-8

require 'cgi'

def mark_waiting_play
  'play'
end

def mark_waiting_pause
  'pause'
end

Then /^I should see play_button waiting "([^\"]*)"$/ do |expected_mark|

  quote = get_selector_quote(expected_mark)
  check_element_exists("label marked:#{quote}#{expected_mark}#{quote}")
end

Then /^I should not see play_button waiting "([^\"]*)"$/ do |expected_mark|

  quote = get_selector_quote(expected_mark)
  check_element_does_not_exist_or_is_not_visible("label marked:#{quote}#{expected_mark}#{quote}")
end


Then /^I should see an alert view titled "([^\"]*)"$/ do |expected_mark|
  values = frankly_map( 'alertView', 'message')
  puts values
  values.should include(expected_mark)
end
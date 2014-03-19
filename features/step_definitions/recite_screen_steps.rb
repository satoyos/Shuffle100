# coding: utf-8

require 'cgi'

def mark_waiting_play
  'play'
end

def mark_waiting_pause
  'pause'
end

def forced_touch( selector )
  touch_successes = frankly_map( selector, 'FEX_forcedTouch' )
  raise "could not find anything matching [#{selector}] to touch" if touch_successes.empty?
  raise 'some views could not be touched' if touch_successes.include?(false)
  touch_successes
end

def poem_number_label_of(number)
  '%03d' % number
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

When /^I forced_touch "([^\"]*)"$/ do |mark|
  quote = get_selector_quote(mark)
  selector = "view marked:#{quote}#{mark}#{quote} first"
  if element_exists(selector)
    forced_touch( selector )
  else
    raise "Could not touch [#{mark}], it does not exist."
  end
  sleep 1
end

When /^I touch (\d+) poems at random$/ do |ordinal|
  ordinal = ordinal.to_i
  (1..8).to_a.shuffle.slice(0, ordinal).each do |number|
    puts ' - 歌番号[%3d]の歌を選びます。' % number
    quote = get_selector_quote(poem_number_label_of(number))
    touch("tableViewCell marked:#{quote}#{poem_number_label_of(number)}#{quote}")
  end
end


When(/^I flip switch "([^\"]*)" on$/) do |mark|
  quote = get_selector_quote(mark)
  selector = "view:'UISwitch' marked:#{quote}#{mark}#{quote}"
  if element_exists(selector)
    frankly_map( selector, "set_on" )
  else
    raise "Could not touch [#{mark}], it does not exist."
  end
end
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

When(/^I flip switch "([^\"]*)" off$/) do |mark|
  quote = get_selector_quote(mark)
  selector = "view:'UISwitch' marked:#{quote}#{mark}#{quote}"
  if element_exists(selector)
    frankly_map( selector, "set_off" )
  else
    raise "Could not touch [#{mark}], it does not exist."
  end
end

Then /^I forcedly navigate back$/ do
  forced_touch( "navigationItemButtonView" )
  wait_for_nothing_to_be_animating
end

def play_button_mark
  'play_button'
end


def wait_to_see(expected_mark)
  puts "Then I wait to see #{expected_mark}"
  quote = get_selector_quote(expected_mark)
  wait_until(:message => "waited to see view marked #{quote}#{expected_mark}#{quote}") {
    view_with_mark_exists(expected_mark)
  }
end

def touch2(mark)
  # puts '- touch in my steps'
  quote = get_selector_quote(mark)
  selector = "view marked:#{quote}#{mark}#{quote} first"
  if element_exists(selector)
    touch( selector )
  else
    raise "Could not touch [#{mark}], it does not exist."
  end
  sleep 1
end

Then /^I can go through (\d+) poems$/ do |poems_num|
  puts "#{Time.now} - [#{poems_num}] Loop Start!"
  puts "poems_num => #{poems_num} (#{poems_num.class})"
  q = get_selector_quote(play_button_mark)
  (1..poems_num.to_i).each do |idx|
    # Then I wait to see "1首め"
    wait_to_see('%d首め' % idx)
    # Then I wait to see "下"
    sleep 2
    wait_to_see('下')
    # When I touch "play_button"
    sleep 1.5
    touch2(play_button_mark)
  end
  puts "#{Time.now} - [#{poems_num}] Loop End!"
end

Then /^I can go through (\d+) poems with skip$/ do |poems_num|
  puts "#{Time.now} - [#{poems_num}] Loop Start!"
  puts "poems_num => #{poems_num} (#{poems_num.class})"
  q = get_selector_quote(play_button_mark)
  (1..poems_num.to_i).each do |idx|
    # Then I wait to see "1首め"
    wait_to_see('%d首め' % idx)
    # スキップで上の句の読み上げが終わったら、下の句の読み上げ待ちになる
    sleep 2
    # When I touch the button marked "forward"
    touch2 "forward"
    # Then I wait to see "下"
    sleep 2
    wait_to_see('下')

    # When I touch "play_button"
    # sleep 0.6
    touch2(play_button_mark)

    # When I touch the button marked "forward"
    touch2 "forward"
  end
  puts "#{Time.now} - [#{poems_num}] Loop End!"
end
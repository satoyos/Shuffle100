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


=begin
Then /^I should see play_button waiting_pause$/ do

  quote = get_selector_quote(mark_waiting_pause)
  check_element_exists("label marked:#{quote}#{mark_waiting_pause}#{quote}")
#  element_exists("button marked:#{quote}#{mark_waiting_pause}#{quote}")
end

Then /^I should see play_button waiting_play$/ do

  quote = get_selector_quote(mark_waiting_play)
#  check_element_exists("button marked:#{quote}#{mark_waiting_pause}#{quote}")
  check_element_exists("label marked:#{quote}#{mark_waiting_play}#{quote}")
end
=end

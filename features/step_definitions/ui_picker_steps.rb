When /^I select (\d*)(?:st|nd|rd|th)? row in picker "([^\"]*)"$/ do |row_ordinal, theview|
  selector = "view:'UIPickerView' marked:'#{theview}'"
  row_index = row_ordinal.to_i - 1
  views_switched = frankly_map( selector,
                                'selectRow:inComponent:animated:', row_index, 0, false )
  raise "could not find anything matching [#{row_ordinal}] to switch" if views_switched.empty?
end
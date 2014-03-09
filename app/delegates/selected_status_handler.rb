module SelectedStatusHandler
  def save_selected_status(status100)
    puts '- saving [selected_status]'
    puts "  number_of(true) => #{status100.selected_num}"
#    settings[:selected_status] = status100
#    NSUserDefaults[:selected_status] = status100
    app_delegate.current_status100 = status100
  end

  def loaded_selected_status
    puts '- loading [selected_status]'
    puts " number_of(true => #{app_delegate.current_status100.selected_num}"
#    status100 = settings.selected_status
#    status100 = NSUserDefaults[:selected_status]
    status100 = app_delegate.current_status100
    case status100
      when nil ; nil
      else
#        puts "  loaded_status_array => #{status100}"
        status100
    end
  end

end
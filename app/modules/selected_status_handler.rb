module SelectedStatusHandler
  def save_selected_status(status100)
    app_delegate.current_status100 = status100
  end

  # @return [SelectedStatus100]
  def loaded_selected_status
    status100 = app_delegate.current_status100
    case status100
      when nil ; nil
      else
        status100
    end
  end

end
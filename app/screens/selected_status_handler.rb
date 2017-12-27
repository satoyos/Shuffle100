module SelectedStatusHandler

  attr_reader :status100, :badge_button

  # PM::Screen version of willAppear()
  def will_appear
    update_badge_value
  end

  def init_selected_status_and_badge
    init_members
    set_badge_button
    badge_button.button_size_plus(2)
    self
  end

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

  private

  def update_badge_value
    badge_button.badgeValue = "#{status100.selected_num}首"
  end


  def init_members
    @status100 = loaded_selected_status
    @badge_button = PoemsNumberSelectedItem.create_with_origin_x(-50)
  end

  def set_badge_button
    set_nav_bar_button :right, {
        button: badge_button
    }
  end
end
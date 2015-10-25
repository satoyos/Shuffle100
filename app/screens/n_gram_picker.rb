class NGramPicker < PM::Screen
  include SelectedStatusHandler
  include NGramPickerDataSource
  include NGramPickerDelegate

  title '1字目で選ぶ'

  attr_reader :table_view, :badge_button

  def on_load
    view.backgroundColor = UIColor.whiteColor
    init_members
    init_table_view
    add table_view
    set_badge_button
    badge_button.button_size_plus(2)
  end

  def init_table_view
    @table_view =
        UITableView.alloc.initWithFrame(frame,
                                        style: UITableViewStyleGrouped).tap do |t_view|
          t_view.dataSource = self
          t_view.delegate = self
        end
  end

  def on_appear
    table_view.reloadData
  end

  def test_set_status100(bool_or_booleans)
    @status100 = SelectedStatus100.new(bool_or_booleans)
  end

  private

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
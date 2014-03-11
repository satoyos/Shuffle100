#class NGramPicker < UIViewController
class NGramPicker < PM::Screen
  include SelectedStatusHandler
  include NGramPickerDataSource
  include NGramPickerDelegate

  title '1字目で選ぶ'

  attr_reader :table_view

  def on_load

    view.backgroundColor = UIColor.whiteColor
    @status100 = loaded_selected_status
    init_table_view
    add table_view
  end

  def init_table_view
    @table_view =
        UITableView.alloc.initWithFrame(frame,
                                        style: UITableViewStyleGrouped).tap do |t_view|
          t_view.dataSource = self
          t_view.delegate = self
        end
  end


#  def viewDidAppear(animated)
  def on_appear
    table_view.reloadData
  end

  def test_set_status100(bool_or_booleans)
    @status100 = SelectedStatus100.new(bool_or_booleans)
  end

end
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
    budge_button_size_plus(2)
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
    @badge_button = BBBadgeBarButtonItem.alloc.initWithCustomUIButton(UIButton.alloc.init).tap do |bb|
      bb.badgeOriginX = -50.0
    end
  end

  def budge_button_size_plus(plus_size)
    org_font_size = badge_font.pointSize
    badge_button.badgeFont = badge_font.fontWithSize(org_font_size + plus_size)
  end

  def set_badge_button
    set_nav_bar_button :right, {
        button: badge_button
    }
  end

  def badge_font
    badge_button.badgeFont
  end
end
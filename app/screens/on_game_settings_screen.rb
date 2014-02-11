class OnGameSettingsScreen < PM::TableScreen
  title 'いろいろな設定'

  def on_load
    set_nav_bar_button :right, title: '設定終了', action: :done_button_did_pushed
  end

  def will_appear
    set_attributes self.view, {
        background_color: hex_color('FFFFFF')
    }
  end

  def table_data

    [{
        cells: [
            {
                title: '歌と歌の間隔',
                cell_class: IntervalSettingCell,
            }
        ]
     }]
  end
=begin
  def initWithRoot(root)
    super

    section = QSection.alloc.init
    label = QLabelElement.alloc.initWithTitle('Hallo', Value: 'world!')
    root.addSection(section)
    section.addElement(label)
  end
=end

=begin
  def viewDidLoad
    super

    puts 'viewDidLoad (in OnGameSettingsController) was called!'

    self.navigationItem.rightBarButtonItem = bar_button_done

  end
=end

=begin
  def initialize_custom_part
    self.navigationItem.rightBarButtonItem = bar_button_done
  end

  def bar_button_done
    @done_button ||=
        UIBarButtonItem.alloc.initWithBarButtonSystemItem(UIBarButtonItemStyleDone,
                                                          target: self,
                                                          action: 'done_button_did_pushed:')
  end
=end



  def done_button_did_pushed
    puts 'Done button pushed.' if BW::debug?
    close
  end

end

class IntervalSettingCell < ProMotion::TableViewCell
  def setup(data_cell, screen)
    super
    label = UILabel.alloc.initWithFrame(CGRectZero).tap do |l|
      l.text = '1.00秒'
      l.sizeToFit
      l.frame =
          [
              [
                  self.frame.size.width - l.frame.size.width - 30,
                  (self.frame.size.height - l.frame.size.height)/2
              ],
              l.frame.size
          ]
    end
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator
    data_cell[:subviews] = [label]
    set_subviews

    self
  end
end
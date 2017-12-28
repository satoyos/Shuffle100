class FiveColorsScreen < PM::Screen
  include SelectedStatusHandler
  include FiveColors

  title '五色百人一首'

  BAR_BUTTON_SIZE = 14

  attr_reader :layout

  def on_load
    @layout = FiveColorsLayout.new.tap{|l|
      l.sizes = app_delegate.sizes ? app_delegate.sizes :
                    OH::DeviceSizeManager.select_sizes  # こっちはRSpecテスト用。
    }
    self.view = layout.view
    self.navigationItem.prompt = AppDelegate::PROMPT
    set_button_actions
    init_selected_status_and_badge
  end

  private

  def set_button_actions
    layout.get(:blue_group_button).on(:touch) {
      blue_color_button_pushed
    }
  end

  def blue_color_button_pushed
    puts '+ 「青グループ」ボタンが押された！' if BW2.debug?
    alert = UIAlertController.alertControllerWithTitle('青色の20首をどうしますか？', message: 'aaa', preferredStyle: UIAlertControllerStyleActionSheet)
    select20 = UIAlertAction.actionWithTitle(
        'この20首だけを選ぶ',
        style: UIAlertActionStyleDefault,
        handler: Proc.new {|obj|
          puts "[20首だけ選ぶ]が選択された"
          select_just20(:blue)
        }
    )
    add20 = UIAlertAction.actionWithTitle(
        '今選んでいる札に加える',
        style: UIAlertActionStyleDefault,
        handler: Proc.new {|obj|
          puts "[追加する]が選択された"
          add_20_of_color(:blue)
        }
    )
    cancel = UIAlertAction.actionWithTitle(
        'キャンセル',
        style: UIAlertActionStyleCancel,
        handler: nil)
    alert.addAction(select20)
    alert.addAction(add20)
    alert.addAction(cancel)
    self.presentViewController(alert, animated: true, completion: nil)
  end

  def select_just20(color_sym)
    status100.cancel_all
    status100.select_in_numbers(numbers_of_color(color_sym))
    save_selected_status(status100)
    update_badge_value
  end

  def add_20_of_color(color_sym)
    status100.select_in_numbers(numbers_of_color(color_sym))
    save_selected_status(status100)
    update_badge_value
  end

=begin
  def numbers_of_color(color_sym)
    case color_sym
      when :blue;   FiveColors::BLUE
      when :yellow; FiveColors::YELLOW
      when :green;  FiveColors::GREEN
      when :pink;   FiveColors::PINK
      when :orange; FiveColors::ORANGE
      else
        purs("xxxx ERROR: [#{color_sym}]の色はサポートしていません。 xxxx")
        []
    end
  end
=end
end

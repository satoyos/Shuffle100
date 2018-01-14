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

  def selected_status_of_color(color_sym)
    raise "Invalid argument type #{color_sym}" unless color_sym.is_a? Symbol
    numbers = numbers_of_color(color_sym)
    raise "Couldn't get Numbers for Color [#{color_sym}]" if numbers.empty?
    if numbers.inject(true){|result, num| result &&= status100.of_number(num)}
      :full # 該当する歌が全て選択されているとき
    elsif !numbers.inject(false) { |result, num| result ||= status100.of_number(num) }
      :none # 該当する歌が一つも選択されてないとき
    else
      :partial # 中途半端に選択されているとき
    end
  end

  private

  def set_button_actions
    FIVE_COLOR_SYMBOLS.each do |color_sym|
      button_of_color(color_sym).on(:touch) {
        pushed_button_of_color(color_sym)
      }
    end
  end

  def pushed_button_of_color(color_sym)
    puts "+ 「#{str_of_color(color_sym)}グループ」ボタンが押された！" if BW2.debug?
    alert = UIAlertController.alertControllerWithTitle(
        "#{str_of_color(color_sym)}色の20首をどうしますか？",
        message: nil,
        preferredStyle: UIAlertControllerStyleActionSheet)
    select20 = UIAlertAction.actionWithTitle(
        'この20首だけを選ぶ',
        style: UIAlertActionStyleDefault,
        handler: Proc.new {|obj|
          puts "[20首だけ選ぶ]が選択された"
          select_just20(color_sym)
        }
    )
    add20 = UIAlertAction.actionWithTitle(
        '今選んでいる札に加える',
        style: UIAlertActionStyleDefault,
        handler: Proc.new {|obj|
          puts "[追加する]が選択された"
          add_20_of_color(color_sym)
        }
    )
    cancel = UIAlertAction.actionWithTitle(
        'キャンセル',
        style: UIAlertActionStyleCancel,
        handler: nil)
    alert.addAction(select20)
    alert.addAction(add20)
    alert.addAction(cancel)

    # iPad用の設定
    if pc = alert.popoverPresentationController
      pc.sourceView = button_of_color(color_sym)
      pc.sourceRect = CGRectMake(0, 0, 1, 1)
    end

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

  def button_of_color(color_sym)
    layout.get("#{color_sym}_group_button".to_sym)
  end

end

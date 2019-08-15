module PoemPickerDelegate

  def poem_tapped(poem)
    status100.reverse_in_number(poem.number)
    update_table_and_prompt
    updateSearchResultsForSearchController(@search_controller) if @search_controller
  end

  def poem_long_pressed(poem)
    puts "▲ 歌番号#{poem.number}番の取り札を表示します。" if BW2.debug?
    open_modal FudaScreen.new(nav_bar: true).tap{|s|
                 s.fuda_str = poem.in_hiragana.shimo
                 puts "→表示する下の句: #{s.fuda_str}" if BW2.debug?
                 s.nav_bar_title = poem.str_with_number_and_liner
               }
  end

  def select_all_poems
    if searching?
      status100.select_in_numbers(filtered_poem_numbers)
      update_table_and_prompt
      refresh_search_result_table
    else
      status100.select_all
      update_table_and_prompt
    end
  end

  def cancel_all_poems
    if searching?
      status100.cancel_in_numbers(filtered_poem_numbers)
      update_table_and_prompt
      refresh_search_result_table
    else
      status100.cancel_all
      update_table_and_prompt
    end
  end

  def select_by_group
    puts '「まとめて選ぶ」が選択された！' if BW2.debug?
    alert = ActionAlertFactory.create_alert({
            title: 'どうやって選びますか？',
            message: nil,
            actions: actions_for_selection,
            cancel_title: 'キャンセル'
        })

    # iPad用の設定
    if pc = alert.popoverPresentationController
      pc.sourceView = navigation_controller.toolbar
      pc.sourceRect = CGRectMake(pc.sourceView.frame.size.width, 0, 1, 1)
    end

    self.presentViewController(alert, animated: true, completion: nil)
  end

  def save_button_tapped(sender)
    puts '「保存」ボタンが押された！' if BW2.debug?
    if status100.selected_num == 0
      show_empty_error_alert
      return
    end
    alert = ActionAlertFactory.create_alert({
            title: '選んでいる札をどのように保存しますか？',
            message: nil,
            actions: actions_for_save,
            cancel_title: 'キャンセル'
        })

    # iPad用の設定
    if pc = alert.popoverPresentationController
      pc.sourceView = sender
      # pc.sourceRect = CGRectMake(pc.sourceView.frame.size.width, 0, 1, 1)
      pc.sourceRect = sender.frame
    end

    self.presentViewController(alert, animated: true, completion: nil)
  end

  def show_empty_error_alert
    UIAlertView.alloc.init.tap{|alert_view|
      alert_view.title ='歌を選びましょう'
      alert_view.message = "空の札セットは作成できません"
      alert_view.addButtonWithTitle('戻る')
    }.show
  end

  def select_by_five_colors
    puts "You select 五色から選ぶ！" if BW2.debug?
    open FiveColorsScreen.new
  end

  def select_by_ngram
    if searching?
      alert_ngram_picker_disabled
      return
    end
    open NGramPicker.new
  end

  private

  def actions_for_save
    actions = [
        {
            title: '新しい札セットとして保存する',
            handler: Proc.new {|obj|
              puts "[新しい札セット]が選択された" if BW2.debug?
              open NameNewSetScreen.new, modal: true, nav_bar: true
            }
        }
    ]
    if saved_fuda_set_exist?
      actions << {
          title: '前に作った札セットに上書きする',
          handler: Proc.new {|obj|
            puts "[上書き]が選択された" if BW2.debug?
            open OverwriteSetScreen.new, modal: true, nav_bar: true
          }
      }
    end
    actions
  end

  def actions_for_selection
    actions = [
        action_for_select_by_ngram,
=begin
        {
            title: '「五色百人一首」の色で選ぶ',
            handler: Proc.new {|obj|
              puts "[五色百人一首で選ぶ]が選択された" if BW2.debug?
              select_by_five_colors
            }
        }
=end
    ]
    if saved_fuda_set_exist?
      actions.insert(0, action_for_select_from_fuda_sets)
    end
    actions
  end

  def saved_fuda_set_exist?
    app_delegate.game_settings.fuda_sets.size > 0
  end

  def action_for_select_from_fuda_sets
    {
        title: '作った札セットから選ぶ',
        handler: Proc.new {|obj|
          puts "[札セットから選ぶ]が選択された" if BW2.debug?
          open FudaSetsScreen
        }
    }
  end

  def action_for_select_by_ngram
    {
        title: '1字目で選ぶ',
        handler: Proc.new {|obj|
          puts "[1字目で選ぶ]が選択された" if BW2.debug?
          select_by_ngram
        }
    }
  end

  def alert_action_cancel
    UIAlertAction.actionWithTitle(
        'キャンセル',
        style: UIAlertActionStyleCancel,
        handler: nil)
  end
end
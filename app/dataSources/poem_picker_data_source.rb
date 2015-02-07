module PoemPickerDataSource

  SELECTED_BG_COLOR = '#eebbcb'.uicolor #撫子色

  def table_data
    [{
         cell_style: UITableViewCellStyleValue1,
         cells: poems.map{|poem|
           {
               title: poem.str_with_number_and_liner('%3d. %s %s %s %s %s'),
               subtitle: "　　 #{poem.poet}  #{poem.living_years}",
               search_text: search_text_for_poem(poem),
               action: :poem_tapped,
               long_press_action: :poem_long_pressed,
               arguments: poem,
               style: {
                   font: UIFont.fontWithName('HiraMinProN-W6', size: MDT::Font.body.pointSize),
                   background_color: bg_color_for_poem(poem),
                   accessibility_label: '%03d' % poem.number,
                   accessory_type: acc_type_for_poem(poem),
               },
               height: MDT::Font.body.pointSize * 3
           }
         }
     }]
  end

  private

  # @param [Poem] poem
  # @return [UIColor]
  def bg_color_for_poem(poem)
    status100.of_number(poem.number) ?
        SELECTED_BG_COLOR :
        UIColor.whiteColor
  end

  # @param [Poem] poem
  # @return [UITableViewCellEditingStyle]
  def acc_type_for_poem(poem)
    status100.of_number(poem.number) ?
        UITableViewCellAccessoryCheckmark :
        UITableViewCellAccessoryNone
  end

  # @param [Poem] poem
  # @return [String]
  def search_text_for_poem(poem)
    [poem.liner, poem.in_hiragana, poem.in_modern_kana, poem.poet, poem.kimari_ji].
        flatten.join(' ')
  end

end
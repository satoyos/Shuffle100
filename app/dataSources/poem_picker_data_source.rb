module PoemPickerDataSource


  SELECTED_BG_COLOR = '#eebbcb'.to_color #撫子色

  def table_data
    [{
         cell_style: UITableViewCellStyleValue1,
         cells: poems.map{|poem|
           {
               # cell_class: PoemPickerTableCell,
               title: '%3d. %s %s %s' %
                   [poem.number, poem.liner[0], poem.liner[1], poem.liner[2]],

               font: UIFont.fontWithName('HiraMinProN-W6', size: 16),
               subtitle: "　　 #{poem.poet}",
               accessory_type: status100.of_number(poem.number) ?
                   UITableViewCellAccessoryCheckmark :
                   UITableViewCellAccessoryNone,
               background_color: status100.of_number(poem.number) ?
                   SELECTED_BG_COLOR :
                   UIColor.whiteColor,
               action: :poem_tapped,
               arguments: {number: poem.number}
           }
         }
     }]
  end

  def poem_tapped(arg_hash)
    status100.reverse_in_number(arg_hash[:number])
    self.navigationItem.prompt = '選択中: %d首' % status100.selected_num

    update_table_data

  end

=begin
  def tableView(tableView, numberOfRowsInSection: section)
    poems.size
  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    @reuseIdentifier ||= 'CELL_IDENTIFIER'

    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier) ||
        UITableViewCell.alloc.initWithStyle(UITableViewCellStyleSubtitle,
                                            reuseIdentifier: @reuseIdentifier)

    poem = poems[indexPath.row]
    cell.tap do |c|
      c.textLabel.text = '%3d. %s %s %s' %
          [poem.number, poem.liner[0], poem.liner[1], poem.liner[2]]
      c.textLabel.font = UIFont.fontWithName('HiraMinProN-W6',
                                             size: c.textLabel.font.pointSize)
      c.detailTextLabel.text = "　　 #{poem.poet}"
      c.detailTextLabel.font =
          UIFont.fontWithName('HiraMinProN-W3',
                              size: c.detailTextLabel.font.pointSize)
      c.accessoryType = case status100[indexPath.row]
                          when true ; UITableViewCellAccessoryCheckmark
                          else ; UITableViewCellAccessoryNone
                        end
      c.accessibilityLabel = '%03d' % poem.number
    end

  end
=end

=begin
  def tableView(tableView, willDisplayCell: cell, forRowAtIndexPath: indexPath)
    cell.backgroundColor = status100[indexPath.row] ? SELECTED_BG_COLOR : UIColor.whiteColor
    cell.accessoryType =  status100[indexPath.row] ?
        UITableViewCellAccessoryCheckmark :
        UITableViewCellAccessoryNone
    self.navigationItem.prompt = '選択中: %d首' % status100.selected_num
  end
=end

  def poems
    @poems ||= Deck.original_deck.poems
  end
end
module PoemPickerDataSource

  FONT_SIZE = 16
  DETAIL_FONT_SIZE = 11

  SELECTED_BG_COLOR = '#eebbcb'.to_color #撫子色

  def init_data_source
    @poems = Deck.original_deck.poems
  end

  def tableView(tableView, numberOfRowsInSection: section)
    100
  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    @reuseIdentifier ||= 'CELL_IDENTIFIER'

    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier) ||
        UITableViewCell.alloc.initWithStyle(UITableViewCellStyleSubtitle,
                                            reuseIdentifier: @reuseIdentifier)

    poem = @poems[indexPath.row]
    cell.tap do |c|
      c.textLabel.text = '%3d. %s %s %s' % [poem.number, poem.liner[0], poem.liner[1], poem.liner[2]]
      c.textLabel.font = FontFactory.create_font_with_type(:japaneseW6,
                                                           size: FONT_SIZE)
      c.detailTextLabel.text = "　　 #{poem.poet}"
      c.detailTextLabel.font =
          FontFactory.create_font_with_type(:japanese,
                                            size: DETAIL_FONT_SIZE)
    end

    cell.accessoryType = case @status100[indexPath.row]
                           when true ; UITableViewCellAccessoryCheckmark
                           else ; UITableViewCellAccessoryNone
                         end
    cell
  end

  def tableView(tableView, willDisplayCell: cell, forRowAtIndexPath: indexPath)
    cell.backgroundColor = case @status100[indexPath.row]
                             when true ; SELECTED_BG_COLOR
                             else ; UIColor.whiteColor
                           end
#    self.title = '選択中: %d首' % @status100.selected_num
    self.navigationItem.prompt = '選択中: %d首' % @status100.selected_num
  end
end
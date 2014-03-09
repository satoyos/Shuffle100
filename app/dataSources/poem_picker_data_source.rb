module PoemPickerDataSource


  LINER_FONT_SIZE = 16
  LINER_FONT = FontFactory.create_font_with_type(:japaneseW6, size: LINER_FONT_SIZE)
  DETAIL_FONT_SIZE = 11
  DETAIL_FONT = FontFactory.create_font_with_type(:japanese, size: DETAIL_FONT_SIZE)

  SELECTED_BG_COLOR = '#eebbcb'.to_color #撫子色

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
      c.textLabel.font = LINER_FONT
      c.detailTextLabel.text = "　　 #{poem.poet}"
      c.detailTextLabel.font = DETAIL_FONT
    end

    cell.accessoryType = case status100[indexPath.row]
                           when true ; UITableViewCellAccessoryCheckmark
                           else ; UITableViewCellAccessoryNone
                         end
    cell
  end

  def tableView(tableView, willDisplayCell: cell, forRowAtIndexPath: indexPath)
    cell.backgroundColor = case status100[indexPath.row]
                             when true ; SELECTED_BG_COLOR
                             else ; UIColor.whiteColor
                           end
    self.navigationItem.prompt = '選択中: %d首' % status100.selected_num
  end

  def poems
    @poems ||= Deck.original_deck.poems
  end
end
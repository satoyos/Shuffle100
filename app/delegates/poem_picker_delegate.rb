module PoemPickerDelegate

  # @param [UITableView] tableView
  def tableView(tableView, didSelectRowAtIndexPath: indexPath)
    @status100.reverse_in_index(indexPath.row)
    save_selected_status(@status100)
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    tableView.reloadData
  end
end
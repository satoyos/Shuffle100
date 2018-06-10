class ActionAlertFactory
  def self.create_alert(init_hash)
    UIAlertController.alertControllerWithTitle(
        init_hash[:title],
        message: init_hash[:message],
        preferredStyle: UIAlertControllerStyleActionSheet).tap do |alert|

    end
  end
end
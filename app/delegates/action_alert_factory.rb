class ActionAlertFactory
  def self.create_alert(init_hash)
    UIAlertController.alertControllerWithTitle(
        init_hash[:title],
        message: init_hash[:message],
        preferredStyle: UIAlertControllerStyleActionSheet).tap do |alert|
      init_aliert_with_hash(alert, init_hash)
    end
  end

  private

  def self.init_aliert_with_hash(alert, init_hash)
    init_hash[:actions].each {|init_action|
      act = UIAlertAction.actionWithTitle(
          init_action[:title],
          style: UIAlertActionStyleDefault,
          handler: init_action[:handler]
      )
      alert.addAction(act)
    }
    alert.addAction(cancel_action_with_title(init_hash[:cancel_title]))
  end

  def self.cancel_action_with_title(title_str)
    UIAlertAction.actionWithTitle(
        title_str,
        style: UIAlertActionStyleCancel,
        handler: nil)
  end
end
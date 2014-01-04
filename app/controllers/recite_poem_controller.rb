class RecitePoemController < UIViewController

  attr_reader :deck

  def initWithDeck(deck, players: players)
    self.initWithNibName(nil, bundle: nil)
    @deck = deck
  end

  def viewDidLoad
    super

  end
end
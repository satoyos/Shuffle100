class RecitePoemController < UIViewController

  attr_reader :deck, :players

  def initWithDeck(deck, players: players)
    self.initWithNibName(nil, bundle: nil)
    @deck = deck
    @players = players
  end

  def viewDidLoad
    super

  end
end
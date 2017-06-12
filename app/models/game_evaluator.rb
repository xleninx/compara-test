class GameEvaluator
  attr_reader :hand_a, :hand_b

  HAND_RANKING = { royal_flush: 10, four_of_a_kind: 9, straight_flush: 8, 
    flush: 7, full_house: 6, straight: 5, three_of_a_kind: 4, two_pairs: 3, 
    one_pair: 2 }

  def initialize(hand_a, hand_b)
    @hand_a = hand_a
    @hand_b = hand_b
  end

  def play
    [hand_a: evaluate(hand_a), hand_b: evaluate(hand_b)]
  end

  def evaluate(hand)
    evaluator = PokerEvaluator.new(hand)
    hand_name = HAND_RANKING.keys.find { |name| evaluator.send("#{name.to_s}?") }
    HAND_RANKING[hand_name]
  end

  def evaluate_high_card
    
  end

end
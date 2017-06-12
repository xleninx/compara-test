class PokerEvaluator

  CARD_VALUES = { "2" =>  2, "3" =>  3, "4" =>  4, "5" =>  5, "6" =>  6, "7" =>  7,
    "8" =>  8, "9" =>  9, "10" => 10, "J" => 11, "Q" => 12, "K" => 13, "A" => 14 }
  RANGE = CARD_VALUES.keys

  def high_card?(card_a, card_b)
    value = [CARD_VALUES[card_a], CARD_VALUES[card_b]].max
    CARD_VALUES.key(value)
  end

  def one_pair?(hand)
    count_by_number(hand).values.include?(2)
  end

  def two_pairs?(hand)
    count_by_number(hand).values.sort == [2, 2, 1].sort
  end

  def three_of_a_kind?(hand)
    count_by_number(hand).values.include?(3)
  end

  def straight?(hand)
    consecutive_cards?(hand, 5)
  end

  def flush?(hand)
    suit_quantity_by?(hand: hand, quantity: 1)
  end

  def full_house?(hand)
    count_by_number(hand).values.sort == [3, 2].sort
  end

  def four_of_a_kind?(hand)
    count_by_number(hand).values.sort == [4, 1].sort
  end

  def straight_flush?(hand)
    consecutive_cards?(hand, 5) && suit_quantity_by?(hand: hand, quantity: 1)
  end

  def royal_flush?(hand)
    suit_quantity_by?(hand: hand, quantity: 1) && include_flush_numbers?(hand)
  end

  private
    def include_flush_numbers?(hand)
      result = flush_array.map{ |value| hand.any? { |card| card.value?(value) } }
      result.uniq.count == 1
    end

    def suit_quantity_by?(hand: nil, quantity: 1)
      hand.group_by{|b| b['suit']}.count == quantity
    end

    def flush_array
      ['10', 'J', 'Q', 'K', 'A']
    end

    def consecutive_cards?(hand, num)
      RANGE.each_cons(num).any? do |straight|
        sort_hand(hand).last(num) == straight
      end
    end

    def sort_hand(hand)
      hand_numbers(hand).sort_by {|card| RANGE.index(card)}
    end

    def hand_numbers(hand)
      hand.map{ |card| card['number'] }
    end

    def count_by_number(hand)
      grouped_hand = hand.group_by{ |card| card['number'] }
      grouped_hand.map{|number, card| [number, card.count]}.to_h
    end

end
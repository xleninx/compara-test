class PokerEvaluator
  attr_reader :hand

  CARD_VALUES = { "2": 2, "3": 3, "4": 4, "5": 5, "6": 6, "7": 7,
    "8": 8, "9": 9, "10": 10, "J": 11, "Q": 12, "K": 13, "A": 14 }
  RANGE = CARD_VALUES.keys

  def initialize(hand = nil)
    @hand = hand
  end

  def high_card?(hand_a, hand_b)
    result = {}
    until result.values.uniq.count == 2
      (0..4).each_with_index do |val, index|
        result = { hand_a: sort_hand(hand_a).reverse[index], hand_b: sort_hand(hand_b).reverse[index] }
      end
    end
    result

  end

  def one_pair?
    count_by_number(hand).values.include?(2)
  end

  def two_pairs?
    count_by_number(hand).values.sort == [2, 2, 1].sort
  end

  def three_of_a_kind?
    count_by_number(hand).values.include?(3)
  end

  def straight?
    consecutive_cards?(hand, 5)
  end

  def flush?
    suit_quantity_by?(hand: hand, quantity: 1)
  end

  def full_house?
    count_by_number(hand).values.sort == [3, 2].sort
  end

  def four_of_a_kind?
    count_by_number(hand).values.sort == [4, 1].sort
  end

  def straight_flush?
    consecutive_cards?(hand, 5) && suit_quantity_by?(hand: hand, quantity: 1)
  end

  def royal_flush?
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
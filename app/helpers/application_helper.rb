module ApplicationHelper

  def suit_char(suit_name)
    suit_hash[suit_name.to_sym]
  end

  def suit_hash
    { 
      'spades': '♠',
      'diamonds': '♦',
      'hearts': '♥',
      'clubs': '♣'
    }
  end
end

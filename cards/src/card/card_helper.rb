require_relative 'card'

class CardHelper

  def self.push_back_without_duplicate(optional_cards,cards)
    copyed_optional_cards = optional_cards.dup
    result = copyed_optional_cards.select{|i| i == cards}

    if 0 == result.length()
      copyed_optional_cards << cards
    end
    return copyed_optional_cards
  end

  def self.convert_cards_array_to_cards(optional_cards)
    card_array = Array.new
    for i in 0..optional_cards.length() -1
      cards = optional_cards[i]
      if !cards.nil?
        for j in 0..cards.length() -1
          card_array << cards[j]
        end
      end
    end
    return card_array
  end

end
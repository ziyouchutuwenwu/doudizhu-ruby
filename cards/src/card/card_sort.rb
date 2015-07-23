require_relative 'card'

class CardSort

  def self.inc_sort_cards(cards)
    for i in 0..cards.length()-1
      for j in 0..cards.length()-1 -i -1
        if cards[j] > cards[j+1]
          cards[j],cards[j+1] = cards[j+1],cards[j]
        end
      end
    end
    return cards
  end

  def self.sort_cards_by_card_number(cards)
    for i in 0..cards.length()-1
      for j in 0..cards.length()-1 -i -1
        card_info = Card.get_card_info_from_integer(cards[j])
        next_card_info = Card.get_card_info_from_integer(cards[j+1])

        if card_info.card_number < next_card_info.card_number
          cards[j],cards[j+1] = cards[j+1],cards[j]
        end
      end
    end
  end
end
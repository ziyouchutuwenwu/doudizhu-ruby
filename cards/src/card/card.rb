require_relative 'card_type_const'
require_relative 'card_info'

class Card

  def self.wash_card
    result = (1..54).to_a.shuffle
    return result
  end

  # 返回CardInfo类型
  def self.get_card_info_from_integer(index)
    card_info = CardInfo.new

    if index.nil?
      card_info.card_type = CardTypeConst::CardType::INVALID
      card_info.card_number = 0
    elsif index < 1 || index > 54
      card_info.card_type = CardTypeConst::CardType::INVALID
      card_info.card_number = 0
    else
      type_number = index / 13
      card_number = index % 13

      if  0 == card_number
        card_number = 13
        type_number = (index - 1) /13
      end

      card_info.card_type = type_number
      card_info.card_number = card_number + 2

      if type_number == CardTypeConst::CardType::WANG
        card_info.card_number += 13
      end
    end

    return card_info
  end

  # 返回map<int,int>
  def self.get_card_map(cards)
    card_map = Hash.new

    if nil != cards
      for i in 0..cards.length - 1
        card_info = get_card_info_from_integer(cards[i])
        card_number = card_map[card_info.card_number].to_i

        if 0 != card_number
          card_map[card_info.card_number] += 1
        else
          card_map[card_info.card_number] = 1
        end
      end
    end

    return card_map
  end

  # 返回CardTypeConst::CardSizeType
  def self.get_cards_general_type(card_map)
    card_type = CardTypeConst::CardSizeType::KEY_SIZE_INVALID

    if 1 == card_map.length()
      card_type = CardTypeConst::CardSizeType::KEY_SIZE_1
    end
    if 2 == card_map.length()
      card_type = CardTypeConst::CardSizeType::KEY_SIZE_2
    end
    if 3 == card_map.length()
      card_type = CardTypeConst::CardSizeType::KEY_SIZE_3
    end
    if 4 == card_map.length()
      card_type = CardTypeConst::CardSizeType::KEY_SIZE_4
    end
    if 5 <= card_map.length()
      card_type = CardTypeConst::CardSizeType::KEY_SIZE_MORE_THAN_5
    end

    return card_type
  end

  # 返回CardTypeConst::CardDetailType
  def self.get_cards_detail_type(card_type,cards)
    cards_detail_type = CardTypeConst::CardDetailType::INVALID_CARD_TYPE

    if 0 == cards.length()
      return cards_detail_type
    end

    case card_type
      when CardTypeConst::CardSizeType::KEY_SIZE_1
        if 1 == cards.length
          cards_detail_type = CardTypeConst::CardDetailType::DAN_ZHANG
        end
        if 2 == cards.length
          cards_detail_type = CardTypeConst::CardDetailType::DUI_ZI
        end
        if 3 == cards.length
          cards_detail_type = CardTypeConst::CardDetailType::SAN_ZHANG
        end
        if 4 == cards.length
          cards_detail_type = CardTypeConst::CardDetailType::ZHA_DAN
        end
      when CardTypeConst::CardSizeType::KEY_SIZE_2
        if 2 == cards.length
          cards_detail_type = CardTypeConst::CardDetailType::WANG_ZHA
        end
        if 4 == cards.length
          cards_detail_type = CardTypeConst::CardDetailType::SAN_DAI_YI
        end
        if 5 == cards.length
          cards_detail_type = CardTypeConst::CardDetailType::SAN_DAI_ER
        end
        if 6 == cards.length
          cards_detail_type = CardTypeConst::CardDetailType::SAN_SHUN_BU_DAI
        end
      when CardTypeConst::CardSizeType::KEY_SIZE_3
        if 6 == cards.length
          cards_detail_type = CardTypeConst::CardDetailType::SHUANG_SHUN
        end
        if 9 == cards.length
          cards_detail_type = CardTypeConst::CardDetailType::SAN_SHUN_BU_DAI
        end
      when CardTypeConst::CardSizeType::KEY_SIZE_4
        if 8 == cards.length
          card_map = get_card_map(cards)
          isShuangShun = false
          card_map.each do |_key,value|
            if 2 == value
              isShuangShun = true
            else
              isShuangShun = false
            end
            if isShuangShun
              cards_detail_type = CardTypeConst::CardDetailType::SHUANG_SHUN
            else
              cards_detail_type = CardTypeConst::CardDetailType::SAN_SHUN_DAI_DAN
            end
          end
        end
        if 10 == cards.length
          cards_detail_type = CardTypeConst::CardDetailType::SAN_SHUN_DAI_SHUANG
        end
        if 12 == cards.length
          cards_detail_type = CardTypeConst::CardDetailType::SAN_SHUN_BU_DAI
        end
      when CardTypeConst::CardSizeType::KEY_SIZE_MORE_THAN_5
        card_map = get_card_map(cards)
        key_size_map = Hash.new
        card_map.each do |_key,value|
          number = key_size_map[value].to_i
          key_size_map[value]  = number + 1
        end

        if 5 <= key_size_map[1].to_i
          cards_detail_type = CardTypeConst::CardDetailType::DAN_SHUN
        end

        if 5 <= key_size_map[2].to_i
          cards_detail_type = CardTypeConst::CardDetailType::SHUANG_SHUN
        end

        if 5 <= key_size_map[3].to_i
          cards_detail_type = CardTypeConst::CardDetailType::SAN_SHUN_BU_DAI
        end

        if 3 <= key_size_map[3].to_i && 2 <= key_size_map[1].to_i
          cards_detail_type = CardTypeConst::CardDetailType::SAN_SHUN_DAI_DAN
        end

        if 3 <= key_size_map[3].to_i && 2 <= key_size_map[2].to_i
          cards_detail_type = CardTypeConst::CardDetailType::SAN_SHUN_DAI_SHUANG
        end
    end

    return cards_detail_type
  end

  def self.get_cards_by_key(cards,key)
    result_cards = Array.new

    for i in 0..cards.length - 1
      card_info = get_card_info_from_integer(cards[i])

      if card_info.card_number == key
        result_cards << cards[i]
      end
    end

    return result_cards
  end
end
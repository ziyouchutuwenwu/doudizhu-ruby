require_relative 'card_type_const'
require_relative 'card'
require_relative 'card_sort'

class CardValidator

  # 返回true或者false
  def self.is_card_validate(cards)
    cards_map = Card.get_card_map(cards)
    cards_type = Card.get_cards_general_type(cards_map)
    cards_detail_type = Card.get_cards_detail_type(cards_type,cards)

    if cards_detail_type == CardTypeConst::CardDetailType::INVALID_CARD_TYPE
      return false
    end

    is_card_validate = false

    if !is_card_validate
      is_card_validate = is_dan_shun_card_validate(cards)
      puts "检测单顺有效 #{is_card_validate}"
    end

    if !is_card_validate
      is_card_validate = is_dan_zhang_card_validate(cards)
      puts "检测单张有效 #{is_card_validate}"
    end

    if !is_card_validate
      is_card_validate = is_dui_zi_card_validate(cards)
      puts "检测对子有效 #{is_card_validate}"
    end

    if !is_card_validate
      is_card_validate = is_san_dai_er_card_validate(cards)
      puts "检测三代二有效 #{is_card_validate}"
    end

    if !is_card_validate
      is_card_validate = is_san_dai_yi_card_validate(cards)
      puts "检测三带一有效 #{is_card_validate}"
    end

    if !is_card_validate
      is_card_validate = is_san_shun_bu_dai_card_validate(cards)
      puts "检测三顺不带有效 #{is_card_validate}"
    end

    if !is_card_validate
      is_card_validate = is_san_shun_dai_dan_card_validate(cards)
      puts "检测三顺带单有效 #{is_card_validate}"
    end

    if !is_card_validate
      is_card_validate = is_san_shun_dai_shuang_card_validate(cards)
      puts "检测三顺带双有效 #{is_card_validate}"
    end

    if !is_card_validate
      is_card_validate = is_san_zhang_card_validate(cards)
      puts "检测三张有效 #{is_card_validate}"
    end

    if !is_card_validate
      is_card_validate = is_shuang_shun_card_validate(cards)
      puts "检测双顺有效 #{is_card_validate}"
    end

    if !is_card_validate
      is_card_validate = is_wang_zha_card_validate(cards)
      puts "检测王炸有效 #{is_card_validate}"
    end

    if !is_card_validate
      is_card_validate = is_zha_dan_card_validate(cards)
      puts "检测炸弹有效#{is_card_validate}"
    end

    return is_card_validate
  end

  # CardTypeConst::CardDetailType
  def self.get_card_type(cards)
    cards_type = Card.get_cards_general_type(cards_map)
    cards_detail_type = Card.get_cards_detail_type(cards_type,cards)

    if cards_detail_type == CardTypeConst::CardDetailType::INVALID_CARD_TYPE
      return cards_detail_type
    end

    is_card_valid = false

    if !is_card_valid
      is_card_valid = is_dan_shun_card_validate(cards)
      if is_card_valid
        cards_detail_type = CardTypeConst::CardDetailType::DAN_SHUN
      end
    end

    if !is_card_valid
      is_card_valid = is_dan_zhang_card_validate(cards)
      if is_card_valid
        cards_detail_type = CardTypeConst::CardDetailType::DAN_ZHANG
      end
    end

    if !is_card_valid
      is_card_valid = is_dui_zi_card_validate(cards)
      if is_card_valid
        cards_detail_type = CardTypeConst::CardDetailType::DUI_ZI
      end
    end

    if !is_card_valid
      is_card_valid = is_san_dai_er_card_validate(cards)
      if is_card_valid
        cards_detail_type = CardTypeConst::CardDetailType::SAN_DAI_ER
      end
    end

    if !is_card_valid
      is_card_valid = is_san_dai_yi_card_validate(cards)
      if is_card_valid
        cards_detail_type = CardTypeConst::CardDetailType::SAN_DAI_YI
      end
    end

    if !is_card_valid
      is_card_valid = is_san_shun_bu_dai_card_validate(cards)
      if is_card_valid
        cards_detail_type = CardTypeConst::CardDetailType::SAN_SHUN_BU_DAI
      end
    end

    if !is_card_valid
      is_card_valid = is_san_shun_dai_dan_card_validate(cards)
      if is_card_valid
        cards_detail_type = CardTypeConst::CardDetailType::SAN_SHUN_DAI_DAN
      end
    end

    if !is_card_valid
      is_card_valid = is_san_shun_dai_shuang_card_validate(cards)
      if is_card_valid
        cards_detail_type = CardTypeConst::CardDetailType::SAN_SHUN_DAI_SHUANG
      end
    end

    if !is_card_valid
      is_card_valid = is_san_zhang_card_validate(cards)
      if is_card_valid
        cards_detail_type = CardTypeConst::CardDetailType::SAN_ZHANG
      end
    end

    if !is_card_valid
      is_card_valid = is_shuang_shun_card_validate(cards)
      if is_card_valid
        cards_detail_type = CardTypeConst::CardDetailType::SHUANG_SHUN
      end
    end

    if !is_card_valid
      is_card_valid = is_wang_zha_card_validate(cards)
      if is_card_valid
        cards_detail_type = CardTypeConst::CardDetailType::WANG_ZHA
      end
    end

    if !is_card_valid
      is_card_valid = is_zha_dan_card_validate(cards)
      if is_card_valid
        cards_detail_type = CardTypeConst::CardDetailType::ZHA_DAN
      end
    end

    return cards_detail_type
  end


  def self.is_dan_shun_card_validate(cards)
    result = false
    cards_map = Card.get_card_map(cards)
    key_array = Array.new
    cards_map.each do |key,value|
      if value == 1 && key >= 3 && key <=14
        key_array << key
      else
        result = false
        return result
      end
    end

    sorted_key_array = CardSort.inc_sort_cards(key_array)

    if sorted_key_array.length < 5
      return false
    end

    for i in 0..sorted_key_array.length() -1
      if i != sorted_key_array.length() -1
        if sorted_key_array[i+1] == sorted_key_array[i]+1
          result = true
        else
          result = false
          break
        end
      end
    end
    return result
  end

  def self.is_dan_zhang_card_validate(cards)
    result = false
    cards_map = Card.get_card_map(cards)
    if 1 != cards_map.length
      return false
    end

    cards_map.each do |key,value|
      if value == 1 && key >= 3 && key <= 17
        result = true
      else
        result = false
        return result
      end
    end

    return result
  end

  def self.is_dui_zi_card_validate(cards)
    result = false
    cards_map = Card.get_card_map(cards)
    if 1 != cards_map.length
      return false
    end

    cards_map.each do |key,value|
      if value == 2 && key >=3 && key <= 15
        result = true
      else
        result = false
        return result
      end
    end
    return result
  end

  def self.is_san_dai_er_card_validate(cards)
    result = false
    cards_map = Card.get_card_map(cards)
    if 2 != cards_map.length
      return false
    end

    has_san_zhang = false
    has_dui_zi = false

    cards_map.each do |key,value|
      if value == 3 && key >= 3 && key <= 15
        has_san_zhang = true
      elsif 2 == value && key >= 3 && key <= 15
        has_dui_zi = true
      else
        has_san_zhang = false
        has_dui_zi = false
        break
      end
    end

    if has_san_zhang && has_dui_zi
      result = true
    end

    return result
  end

  def self.is_san_dai_yi_card_validate(cards)
    result = false
    cards_map = Card.get_card_map(cards)
    if 2 != cards_map.length
      return false
    end

    has_san_zhang = false
    has_dan_zhang = false

    cards_map.each do |key,value|
      if 3 == value && key >= 3 && key <= 15
        has_san_zhang = true
      elsif 1 == value && key >= 3 && key <= 17
        has_dan_zhang = true
      else
        has_san_zhang = false
        has_dan_zhang = false
        break
      end
    end

    if has_san_zhang && has_dan_zhang
      result = true
    end
    return result
  end

  def self.is_san_shun_bu_dai_card_validate(cards)
    result = false
    cards_map = Card.get_card_map(cards)
    key_array = Array.new

    cards_map.each do |key,value|
      if 3 == value && key >= 3 && key <= 14
        key_array << key
      else
        result = false
        return result
      end
    end

    sorted_key_array = CardSort.inc_sort_cards(key_array)
    if sorted_key_array.length < 2
      return false
    end

    for i in 0..sorted_key_array.length() -1
      if i != sorted_key_array.length() - 1
        if sorted_key_array[i+1] == sorted_key_array[i] + 1
          result = true
        else
          result = false
          break
        end
      end
    end

    return result
  end

  def self.is_san_shun_dai_dan_card_validate(cards)
    result = false
    cards_map = Card.get_card_map(cards)

    san_zhang_key_array = Array.new
    dan_zhang_key_array = Array.new

    cards_map.each do |key,value|
      if 3 == value && key >= 3 && key <= 14
        san_zhang_key_array << key
      elsif 1 == value && key >= 3 && key <= 17
        dan_zhang_key_array << key
      else
        result = false
        return result
      end
    end

    sorted_san_zhang_key_array = CardSort.inc_sort_cards(san_zhang_key_array)
    sorted_dan_zhang_key_array = CardSort.inc_sort_cards(dan_zhang_key_array)

    if sorted_dan_zhang_key_array.length() < 2 || sorted_san_zhang_key_array.length() < 2
      return false
    end

    if sorted_dan_zhang_key_array.length() != sorted_san_zhang_key_array.length()
      return false
    end

    for i in 0..sorted_san_zhang_key_array.length() -1
      if i != sorted_san_zhang_key_array.length() -1
        if sorted_san_zhang_key_array[i+1] == sorted_san_zhang_key_array[i]+1
          result = true
        else
          result = false
          break
        end
      end
    end

    return result
  end

  def self.is_san_shun_dai_shuang_card_validate(cards)
    result = false

    cards_map = Card.get_card_map(cards)

    san_zhang_key_array = Array.new
    dui_zi_key_array = Array.new

    cards_map.each do |key,value|
      if 3 == value && key >= 3 && key <= 14
        san_zhang_key_array << key
      elsif 2 == value && key >=3 && key <= 15
        dui_zi_key_array << key
      else
        result = false
        return result
      end
    end

    sorted_san_zhang_key_array = CardSort.inc_sort_cards(san_zhang_key_array)
    sorted_dui_zi_key_array = CardSort.inc_sort_cards(dui_zi_key_array)

    if sorted_dui_zi_key_array.length() < 2 || sorted_san_zhang_key_array.length() < 2
      return false
    end
    if sorted_dui_zi_key_array.length() !=  sorted_san_zhang_key_array.length()
      return false
    end

    for i in 0..sorted_san_zhang_key_array.length()-1
      if i != sorted_san_zhang_key_array.length() - 1
        if sorted_san_zhang_key_array[i+1] == sorted_san_zhang_key_array[i]+1
          result = true
        else
          result = false
          break
        end
      end
    end

    return result
  end

  def self.is_san_zhang_card_validate(cards)
    result = false
    cards_map = Card.get_card_map(cards)
    if 1 != cards_map.length()
      return false
    end

    cards_map.each do |key,value|
      if value == 3 && key >= 3 && key <= 15
        result = true
      else
        result = false
        return result
      end
    end
    return result
  end

  def self.is_shuang_shun_card_validate(cards)
    result = false
    cards_map = Card.get_card_map(cards)

    key_array = Array.new
    cards_map.each do |key,value|
      if value == 2 && key >= 3 && key <= 14
        key_array << key
      else
        result = false
        return result
      end
    end

    sorted_key_array = CardSort.inc_sort_cards(key_array)
    if sorted_key_array.length() < 3
      return false
    end

    for i in 0..sorted_key_array.length()-1
      if i != sorted_key_array.length()-1
        if sorted_key_array[i+1] == sorted_key_array[i]+1
          result = true
        else
          result = false
          break
        end
      end
    end
    return result
  end

  def self.is_wang_zha_card_validate(cards)
    result = false
    if 2 != cards.length()
      return false
    end

    for i in 0..cards.length()-1
      card_info = Card.get_card_info_from_integer(cards[i])

      if card_info.card_type == CardTypeConst::CardType::WANG
        result = true
      else
        result = false
      end
    end
    return result
  end

  def self.is_zha_dan_card_validate(cards)
    result = false
    cards_map = Card.get_card_map(cards)
    if 1 != cards_map.length()
      return false
    end

    cards_map.each do |key,value|
      if value == 4 && key >= 3 && key <= 15
        result = true
      else
        result = false
        return result
      end
    end

    return result
  end
end
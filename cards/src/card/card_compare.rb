require_relative 'card'
require_relative 'card_sort'
require_relative 'card_validator'

class CardCompare

  def self.is_new_cards_larger(new_cards,old_cards)
    result = false

    if !CardValidator.is_card_validate(new_cards) || !CardValidator.is_card_validate(old_cards)
      return false
    end

    old_cards_map = Card.get_card_map(old_cards)
    old_cards_type = Card.get_cards_general_type(old_cards_map)
    old_cards_detail_type = Card.get_cards_detail_type(old_cards_type,old_cards)

    new_cards_map = Card.get_card_map(new_cards)
    new_cards_type = Card.get_cards_general_type(new_cards_map)
    new_cards_detail_type = Card.get_cards_detail_type(new_cards_type,new_cards)

    if new_cards_detail_type < old_cards_detail_type
      result = false
      return result
    end

    if new_cards_detail_type == old_cards_detail_type
      result = is_new_cards_same_type_larger(new_cards,old_cards)
    end

    if new_cards_detail_type > old_cards_detail_type
      if new_cards_detail_type == CardTypeConst::CardDetailType::WANG_ZHA || new_cards_detail_type == CardTypeConst::CardDetailType::ZHA_DAN
        result = true
      else
        result = false
      end
    end

    return result
  end

  def self.is_new_cards_same_type_larger(new_cards,old_cards)
    result = false
    old_cards_map = Card.get_card_map(old_cards)
    old_cards_type = Card.get_cards_general_type(old_cards_map)
    old_cards_detail_type = Card.get_cards_detail_type(old_cards_type,old_cards)

    new_cards_map = Card.get_card_map(new_cards)
    new_cards_type = Card.get_cards_general_type(new_cards_map)
    new_cards_detail_type = Card.get_cards_detail_type(new_cards_type,new_cards)

    if new_cards_detail_type != old_cards_detail_type
      return false
    end

    case new_cards_detail_type
      when CardTypeConst::CardDetailType::DAN_ZHANG
        result = is_dan_zhang_card_larger(new_cards,old_cards)
        puts "比较单张有效 #{result}"
      when CardTypeConst::CardDetailType::DUI_ZI
        result = is_dui_zi_card_larger(new_cards,old_cards)
        puts "比较对子有效 #{result}"
      when CardTypeConst::CardDetailType::SAN_ZHANG
        result = is_san_zhang_card_larger(new_cards,old_cards)
        puts "比较三张有效 #{result}"
      when CardTypeConst::CardDetailType::SAN_DAI_YI
        result = is_san_dai_yi_card_larger(new_cards,old_cards)
        puts "比较三带一有效 #{result}"
      when CardTypeConst::CardDetailType::SAN_DAI_ER
        result = is_san_dai_er_card_larger(new_cards,old_cards)
        puts "比较三带二有效 #{result}"
      when CardTypeConst::CardDetailType::DAN_SHUN
        result = is_dan_shun_card_larger(new_cards,old_cards)
        puts "比较单顺有效 #{result}"
      when CardTypeConst::CardDetailType::SHUANG_SHUN
        result = is_shuang_shun_card_larger(new_cards,old_cards)
        puts "比较双顺有效 #{result}"
      when CardTypeConst::CardDetailType::SAN_SHUN_BU_DAI
        result = is_san_shun_bu_dai_card_larger(new_cards,old_cards)
        puts "比较三顺不带有效 #{result}"
      when CardTypeConst::CardDetailType::SAN_SHUN_DAI_DAN
        result = is_san_shun_dai_dan_card_larger(new_cards,old_cards)
        puts "比较三顺带单有效 #{result}"
      when CardTypeConst::CardDetailType::SAN_SHUN_DAI_SHUANG
        result = is_san_shun_dai_shuang_card_larger(new_cards,old_cards)
        puts "比较三顺带双有效 #{result}"
      when CardTypeConst::CardDetailType::ZHA_DAN
        result = is_zha_dan_card_larger(new_cards,old_cards)
        puts "比较炸弹有效 #{result}"
      when CardTypeConst::CardDetailType::WANG_ZHA
        result = is_wang_zha_card_larger(new_cards,old_cards)
        puts "比较王炸有效 #{result}"
    end
    return result
  end

  def self.is_dan_shun_card_larger(new_cards,old_cards)
    result = false

    if !CardValidator.is_dan_shun_card_validate(new_cards) || !CardValidator.is_dan_shun_card_validate(old_cards)
      return false
    end

    old_card_map = Card.get_card_map(old_cards)
    new_card_map = Card.get_card_map(new_cards)

    old_key_array = Array.new
    old_card_map.each do |key,value|
      if value == 1 && key >= 3 && key <= 14
        old_key_array << key
      end
    end
    old_sorted_key_array = CardSort.inc_sort_cards(old_key_array)

    new_key_array = Array.new
    new_card_map.each do |key,value|
      if value == 1 && key >= 3 && key <= 14
        new_key_array << key
      end
    end
    new_sorted_key_array = CardSort.inc_sort_cards(new_key_array)

    if new_sorted_key_array.length() != old_sorted_key_array.length()
      return false
    end

    if new_sorted_key_array.length() != 0 && old_sorted_key_array.length() != 0
      new_smallest_key = new_sorted_key_array[0]
      old_smallest_key = old_sorted_key_array[0]
      if new_smallest_key > old_smallest_key
        result = true
      else
        result = false
      end
    else
      result = false
    end

    return result
  end

  def self.is_dan_zhang_card_larger(new_cards,old_cards)
    result = false

    if !CardValidator.is_dan_zhang_card_validate(new_cards) || !CardValidator.is_dan_zhang_card_validate(old_cards)
      return false
    end

    old_card_map = Card.get_card_map(old_cards)
    new_card_map = Card.get_card_map(new_cards)

    old_card = 0
    new_card = 0

    old_card_map.each do |key,value|
      if value == 1 && key >= 3 && key <= 17
        old_card = key
        break
      end
    end

    new_card_map.each do |key,value|
      if value == 1 && key >= 3 && key <= 17
        new_card = key
        break
      end
    end

    if new_card > old_card
      result = true
    else
      result = false
    end

    return result
  end

  def self.is_dui_zi_card_larger(new_cards,old_cards)
    result = false

    if !CardValidator.is_dui_zi_card_validate(new_cards) || !CardValidator.is_dui_zi_card_validate(old_cards)
      return false
    end

    old_card_map = Card.get_card_map(old_cards)
    new_card_map = Card.get_card_map(new_cards)

    old_card = 0
    new_card = 0

    old_card_map.each do |key,value|
      if value == 2 && key >= 3 && key <= 15
        old_card = key
        break
      end
    end

    new_card_map.each do |key,value|
      if value == 2 && key >= 3 && key <= 15
        new_card = key
        break
      end
    end
    if new_card > old_card
      result = true
    else
      result = false
    end

    return result
  end

  def self.is_san_dai_er_card_larger(new_cards,old_cards)
    result = false

    if !CardValidator.is_san_dai_er_card_validate(new_cards) || !CardValidator.is_san_dai_er_card_validate(old_cards)
      return false
    end

    old_card_map = Card.get_card_map(old_cards)
    new_card_map = Card.get_card_map(new_cards)

    old_card = 0
    new_card = 0

    old_card_map.each do |key,value|
      if 3 == value && key >= 3 && key <= 15
        old_card = key
        break
      end
    end

    new_card_map.each do |key,value|
      if 3 == value && key >= 3 && key <= 15
        new_card = key
        break
      end
    end

    if new_card > old_card
      result = true
    else
      result = false
    end
    return result
  end

  def self.is_san_dai_yi_card_larger(new_cards,old_cards)
    result = false

    if !CardValidator.is_san_dai_yi_card_validate(new_cards) || !CardValidator.is_san_dai_yi_card_validate(old_cards)
      return false
    end

    old_card_map = Card.get_card_map(old_cards)
    new_card_map = Card.get_card_map(new_cards)

    old_card = 0
    new_card = 0

    old_card_map.each do |key,value|
      if 3 == value && key >= 3 && key <= 15
        old_card = key
        break
      end
    end

    new_card_map.each do |key,value|
      if 3 == value && key >= 3 && key <= 15
        new_card = key
        break
      end
    end

    if new_card > old_card
      result = true
    else
      result = false
    end
    return result
  end

  def self.is_san_shun_bu_dai_card_larger(new_cards,old_cards)
    result = false

    if !CardValidator.is_san_shun_bu_dai_card_validate(new_cards) || !CardValidator.is_san_shun_bu_dai_card_validate(old_cards)
      return false
    end

    old_card_map = Card.get_card_map(old_cards)
    new_card_map = Card.get_card_map(new_cards)

    old_key_array = Array.new
    old_card_map.each do |key,value|
      if value == 3 && key >= 3 && key <= 14
        old_key_array << key
      end
    end
    old_sorted_key_array = CardSort.inc_sort_cards(old_key_array)

    new_key_array = Array.new
    new_card_map.each do |key,value|
      if value == 3 && key >= 3 && key <= 14
        new_key_array << key
      end
    end
    new_sorted_key_array = CardSort.inc_sort_cards(new_key_array)

    if new_sorted_key_array.length() != old_sorted_key_array.length()
      return false
    end

    if new_sorted_key_array.length() != 0 && old_sorted_key_array.length() != 0
      new_smallest_key = new_sorted_key_array[0]
      old_smallest_key = old_sorted_key_array[0]

      if new_smallest_key > old_smallest_key
        result = true
      else
        result = false
      end
    else
      result = false
    end
    return result
  end

  def self.is_san_shun_dai_dan_card_larger(new_cards,old_cards)
    result = false

    if !CardValidator.is_san_shun_dai_dan_card_validate(new_cards) || !CardValidator.is_san_shun_dai_dan_card_validate(old_cards)
      return false
    end

    old_card_map = Card.get_card_map(old_cards)
    new_card_map = Card.get_card_map(new_cards)

    old_key_array = Array.new
    old_card_map.each do |key,value|
      if value == 3 && key >= 3 && key <= 14
        old_key_array << key
      end
    end
    old_sorted_key_array = CardSort.inc_sort_cards(old_key_array)

    new_key_array = Array.new
    new_card_map.each do |key,value|
      if value == 3 && key >= 3 && key <= 14
        new_key_array << key
      end
    end
    new_sorted_key_array = CardSort.inc_sort_cards(new_key_array)

    if new_sorted_key_array.length() != old_sorted_key_array.length()
      return false
    end

    if new_sorted_key_array.length() != 0 && old_sorted_key_array.length() != 0
      new_smallest_key = new_sorted_key_array[0]
      old_smallest_key = old_sorted_key_array[0]

      if new_smallest_key > old_smallest_key
        result = true
      else
        result = false
      end
    else
      result = false
    end
    return result
  end

  def self.is_san_shun_dai_shuang_card_larger(new_cards,old_cards)
    result = false

    if !CardValidator.is_san_shun_dai_shuang_card_validate(new_cards) || !CardValidator.is_san_shun_dai_shuang_card_validate(old_cards)
      return false
    end

    old_card_map = Card.get_card_map(old_cards)
    new_card_map = Card.get_card_map(new_cards)

    old_key_array = Array.new
    old_card_map.each do |key,value|
      if value == 3 && key >= 3 && key <= 14
        old_key_array << key
      end
    end
    old_sorted_key_array = CardSort.inc_sort_cards(old_key_array)

    new_key_array = Array.new
    new_card_map.each do |key,value|
      if value == 3 && key >= 3 && key <= 14
        new_key_array << key
      end
    end
    new_sorted_key_array = CardSort.inc_sort_cards(new_key_array)

    if new_sorted_key_array.length() != old_sorted_key_array.length()
      return false
    end

    if new_sorted_key_array.length() != 0 && old_sorted_key_array.length() != 0
      new_smallest_key = new_sorted_key_array[0]
      old_smallest_key = old_sorted_key_array[0]

      if new_smallest_key > old_smallest_key
        result = true
      else
        result = false
      end
    else
      result = false
    end
    return result
  end

  def self.is_san_zhang_card_larger(new_cards,old_cards)
    result = false

    if !CardValidator.is_san_zhang_card_validate(new_cards) || !CardValidator.is_san_zhang_card_validate(old_cards)
      return false
    end

    old_card_map = Card.get_card_map(old_cards)
    new_card_map = Card.get_card_map(new_cards)

    old_card = 0
    new_card = 0

    old_card_map.each do |key,value|
      if 3 == value && key >= 3 && key <= 15
        old_card = key
        break
      end
    end

    new_card_map.each do |key,value|
      if 3 == value && key >= 3 && key <= 15
        new_card = key
        break
      end
    end

    if new_card > old_card
      result = true
    else
      result = false
    end
    return result
  end

  def self.is_shuang_shun_card_larger(new_cards,old_cards)
    result = false

    if !CardValidator.is_shuang_shun_card_validate(new_cards) || !CardValidator.is_shuang_shun_card_validate(old_cards)
      return false
    end

    old_card_map = Card.get_card_map(old_cards)
    new_card_map = Card.get_card_map(new_cards)

    old_key_array = Array.new
    old_card_map.each do |key,value|
      if value == 2 && key >= 3 && key <= 14
        old_key_array << key
      end
    end
    old_sorted_key_array = CardSort.inc_sort_cards(old_key_array)

    new_key_array = Array.new
    new_card_map.each do |key,value|
      if value == 2 && key >= 3 && key <= 14
        new_key_array << key
      end
    end
    new_sorted_key_array = CardSort.inc_sort_cards(new_key_array)

    if new_sorted_key_array.length() != old_sorted_key_array.length()
      return false
    end

    if new_sorted_key_array.length() != 0 && old_sorted_key_array.length() != 0
      new_smallest_key = new_sorted_key_array[0]
      old_smallest_key = old_sorted_key_array[0]

      if new_smallest_key > old_smallest_key
        result = true
      else
        result = false
      end
    else
      result = false
    end
    return result
  end

  def self.is_wang_zha_card_larger(_new_cards,_old_cards)
    return false
  end

  def self.is_zha_dan_card_larger(new_cards,old_cards)
    result = false

    if !CardValidator.is_zha_dan_card_validate(new_cards) || !CardValidator.is_zha_dan_card_validate(old_cards)
      return false
    end

    old_card_map = Card.get_card_map(old_cards)
    new_card_map = Card.get_card_map(new_cards)

    old_card = 0
    new_card = 0

    old_card_map.each do |key,value|
      if 4 == value && key >= 3 && key <= 15
        old_card = key
        break
      end
    end

    new_card_map.each do |key,value|
      if 4 == value && key >= 3 && key <= 15
        new_card = key
        break
      end
    end

    if new_card > old_card
      result = true
    else
      result = false
    end
    return result
  end
end
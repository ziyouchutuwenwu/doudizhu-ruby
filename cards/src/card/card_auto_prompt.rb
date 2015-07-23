require_relative 'card'
require_relative 'card_sort'
require_relative 'card_helper'
require_relative 'card_validator'
require_relative 'card_debug'

class CardAutoPrompt

  def self.get_auto_larger_cards(original_cards)
    optional_cards = Array.new

    if 0 == optional_cards.length()
      optional_cards = get_auto_san_shun_dai_dan_larger_cards(original_cards)
      puts "三顺带单%d" % optional_cards.length()
    end

    if 0 == optional_cards.length()
      optional_cards = get_auto_san_shun_dai_shuang_larger_cards(original_cards)
      puts "三顺带双%d" % optional_cards.length()
    end

    if 0 == optional_cards.length()
      optional_cards = get_auto_san_shun_bu_dai_larger_cards(original_cards)
      puts "三顺不带%d" % optional_cards.length()
    end

    if 0 == optional_cards.length()
      optional_cards = get_auto_shuang_shun_larger_cards(original_cards)
      puts "双顺%d" % optional_cards.length()
    end

    if 0 == optional_cards.length()
      optional_cards = get_auto_dan_shun_larger_cards(original_cards)
      puts "单顺%d" % optional_cards.length()
    end

    if 0 == optional_cards.length()
      optional_cards = get_auto_san_dai_yi_larger_cards(original_cards)
      puts "三带一%d" % optional_cards.length()
    end

    if 0 == optional_cards.length()
      optional_cards = get_auto_san_dai_er_larger_cards(original_cards)
      puts "三带二%d" % optional_cards.length()
    end

    if 0 == optional_cards.length()
      optional_cards = get_auto_san_zhang_larger_cards(original_cards)
      puts "三张%d" % optional_cards.length()
    end

    if 0 == optional_cards.length()
      optional_cards = get_auto_dui_zi_larger_cards(original_cards)
      puts "对子%d" % optional_cards.length()
    end

    if 0 == optional_cards.length()
      optional_cards = get_auto_dan_zhang_larger_cards(original_cards)
      puts "单张%d" % optional_cards.length()
    end

    if 0 == optional_cards.length()
      optional_cards = get_auto_zha_dan_larger_cards(original_cards)
      puts "炸弹%d" % optional_cards.length()
    end

    if 0 == optional_cards.length()
      optional_cards = get_auto_wang_zha_larger_cards(original_cards)
      puts "王炸%d" % optional_cards.length()
    end
    return optional_cards
  end

  def self.get_auto_dan_shun_larger_cards(original_cards)
    optional_cards = Array.new
    original_cards_map = Card.get_card_map(original_cards)

    original_cards_key_array = Array.new
    original_cards_map.each do |key,value|
      if value >= 1 && key >= 3 && key <= 14
        original_cards_key_array << key
      end
    end
    original_sorted_cards_key_array = CardSort.inc_sort_cards(original_cards_key_array)

    dan_shun_optional_cards = Array.new
    dan_zhang_optional_cards = Array.new
    if original_sorted_cards_key_array.length() > 0
      for i in 0..original_sorted_cards_key_array.length()-1
        dan_zhang_card_array = Array.new
        key = original_sorted_cards_key_array[i]
        result_cards = Card.get_cards_by_key(original_cards,key)

        if result_cards.length() != 0
          card = result_cards[0]
          dan_zhang_card_array << card
        end

        if 0 != dan_zhang_card_array.length()
          dan_zhang_optional_cards << dan_zhang_card_array
        end
      end

      tmp_dan_zhang_optional_cards = Array.new
      for i in 0..dan_zhang_optional_cards.length()-1
        if i == dan_zhang_optional_cards.length()-1
          break
        end

        dan_zhang_cards = dan_zhang_optional_cards[i]
        next_dan_zhang_cards = dan_zhang_optional_cards[i+1]

        dan_zhang_card_info = Card.get_card_info_from_integer(dan_zhang_cards[0])
        next_dan_zhang_card_info = Card.get_card_info_from_integer(next_dan_zhang_cards[0])

        if tmp_dan_zhang_optional_cards.empty?
          if dan_zhang_card_info.card_number + 1 == next_dan_zhang_card_info.card_number
            tmp_dan_zhang_optional_cards = CardHelper.push_back_without_duplicate(tmp_dan_zhang_optional_cards,dan_zhang_cards)
            tmp_dan_zhang_optional_cards = CardHelper.push_back_without_duplicate(tmp_dan_zhang_optional_cards,next_dan_zhang_cards)
          end
        else
          last_cards_object = tmp_dan_zhang_optional_cards[tmp_dan_zhang_optional_cards.length()-1]
          last_card_info = Card.get_card_info_from_integer(last_cards_object[0])

          if dan_zhang_card_info.card_number + 1 == next_dan_zhang_card_info.card_number && last_card_info.card_number == dan_zhang_card_info.card_number
            tmp_dan_zhang_optional_cards = CardHelper.push_back_without_duplicate(tmp_dan_zhang_optional_cards,dan_zhang_cards)
            tmp_dan_zhang_optional_cards = CardHelper.push_back_without_duplicate(tmp_dan_zhang_optional_cards,next_dan_zhang_cards)
          else
            if tmp_dan_zhang_optional_cards.length() < 5
              tmp_dan_zhang_optional_cards.clear()
            end
          end

        end
      end

      dan_shun_card_array = CardHelper.convert_cards_array_to_cards(tmp_dan_zhang_optional_cards)
      dan_shun_optional_cards << dan_shun_card_array

      for i in 0..dan_shun_optional_cards.length() - 1
        dan_shun_cards = dan_shun_optional_cards[i]

        if CardValidator.is_dan_shun_card_validate(dan_shun_cards)
          puts "单顺验证通过"
          for j in 0..dan_shun_cards.length()-1
            CardDebug.print_card_info(dan_shun_cards[j])
          end
          optional_cards << dan_shun_cards
        end
      end
    end

    return optional_cards
  end

  def self.get_auto_dan_zhang_larger_cards(original_cards)
    optional_cards = Array.new
    original_cards_map = Card.get_card_map(original_cards)

    original_cards_key_array = Array.new
    original_cards_map.each do |key,value|
      if value >= 1 && key >= 3 && key <= 17
        original_cards_key_array << key
      end
    end
    original_sorted_cards_key_array = CardSort.inc_sort_cards(original_cards_key_array)

    dan_zhang_optional_cards = Array.new
    if original_sorted_cards_key_array.length() > 0
      for i in 0..original_sorted_cards_key_array.length()-1
        dan_zhang_card_array = Array.new
        key = original_sorted_cards_key_array[i]
        result_cards = Card.get_cards_by_key(original_cards,key)

        if result_cards.length() != 0
          card = result_cards[0]
          dan_zhang_card_array << card
        end

        if 0 != dan_zhang_card_array.length()
          dan_zhang_optional_cards << dan_zhang_card_array
        end
      end

      for i in 0..dan_zhang_optional_cards.length() - 1
        dan_zhang_cards = dan_zhang_optional_cards[i]

        if CardValidator.is_dan_zhang_card_validate(dan_zhang_cards)
          puts "单张验证通过"
          for j in 0..dan_zhang_cards.length()-1
            CardDebug.print_card_info(dan_zhang_cards[j])
          end
          optional_cards << dan_zhang_cards
        end
      end
    end

    return optional_cards
  end

  def self.get_auto_dui_zi_larger_cards(original_cards)
    optional_cards = Array.new
    original_cards_map = Card.get_card_map(original_cards)

    original_cards_key_array = Array.new
    original_cards_map.each do |key,value|
      if value >= 2 && key >= 3 && key <= 15
        original_cards_key_array << key
      end
    end
    original_sorted_cards_key_array = CardSort.inc_sort_cards(original_cards_key_array)

    dui_zi_optional_cards = Array.new
    if original_sorted_cards_key_array.length() > 0
      for i in 0..original_sorted_cards_key_array.length()-1
        dui_zi_card_array = Array.new
        key = original_sorted_cards_key_array[i]
        result_cards = Card.get_cards_by_key(original_cards,key)

        if result_cards.length() >= 2
          for k in 0..1
            card = result_cards[k]
            dui_zi_card_array << card
          end
        end

        if 0 != dui_zi_card_array.length()
          dui_zi_optional_cards << dui_zi_card_array
        end
      end

      for i in 0..dui_zi_optional_cards.length() - 1
        dui_zi_cards = dui_zi_optional_cards[i]

        if CardValidator.is_dui_zi_card_validate(dui_zi_cards)
          puts "对子验证通过"
          for j in 0..dui_zi_cards.length()-1
            CardDebug.print_card_info(dui_zi_cards[j])
          end
          optional_cards << dui_zi_cards
        end
      end
    end

    return optional_cards
  end

  def self.get_auto_san_dai_er_larger_cards(original_cards)
    optional_cards = Array.new
    original_cards_map = Card.get_card_map(original_cards)

    original_cards_key_array = Array.new
    original_cards_map.each do |key,value|
      if value >= 3 && key >= 3 && key <= 15
        original_cards_key_array << key
      elsif value >= 2 && key >= 3 && key <= 15
        original_cards_key_array << key
      end
    end
    original_sorted_cards_key_array = CardSort.inc_sort_cards(original_cards_key_array)

    san_zhang_optional_cards = Array.new
    dui_zi_optional_cards = Array.new
    if original_sorted_cards_key_array.length() > 0
      for i in 0..original_sorted_cards_key_array.length()-1
        san_zhang_card_array = Array.new
        dui_zi_card_array = Array.new

        key = original_sorted_cards_key_array[i]
        result_cards = Card.get_cards_by_key(original_cards,key)

        if result_cards.length() >= 3
          for k in 0..2
            card = result_cards[k]
            san_zhang_card_array << card
          end
        elsif result_cards.length() >= 2
          for k in 0..1
            card = result_cards[k]
            dui_zi_card_array << card
          end
        end

        if 0 != san_zhang_card_array.length()
          san_zhang_optional_cards << san_zhang_card_array
        end

        if 0 != dui_zi_card_array.length()
          dui_zi_optional_cards << dui_zi_card_array
        end
      end

      for i in 0..san_zhang_optional_cards.length()-1
        temp_composed_optional_cards = Array.new
        san_zhang_cards = san_zhang_optional_cards[i]
        for k in 0..san_zhang_cards.length()-1
          temp_composed_optional_cards << san_zhang_cards[k]
        end

        for j in 0..dui_zi_optional_cards.length()-1
          composed_optional_cards = temp_composed_optional_cards.dup
          dui_zi_cards = dui_zi_optional_cards[j]
          for k in 0..dui_zi_cards.length()-1
            composed_optional_cards << dui_zi_cards[k]
          end

          if CardValidator.is_san_dai_er_card_validate(composed_optional_cards)
            puts "自动三带二验证通过"
            for i in 0..composed_optional_cards.length()-1
              CardDebug.print_card_info(composed_optional_cards[i])
            end
            optional_cards << composed_optional_cards
          end
          next
        end
      end
    end

    return optional_cards
  end

  def self.get_auto_san_dai_yi_larger_cards(original_cards)
    optional_cards = Array.new
    original_cards_map = Card.get_card_map(original_cards)

    original_cards_key_array = Array.new
    original_cards_map.each do |key,value|
      if value >= 3 && key >= 3 && key <= 15
        original_cards_key_array << key
      elsif value >= 1 && key >= 3 && key <= 17
        original_cards_key_array << key
      end
    end
    original_sorted_cards_key_array = CardSort.inc_sort_cards(original_cards_key_array)

    san_zhang_optional_cards = Array.new
    dan_zhang_optional_cards = Array.new
    if original_sorted_cards_key_array.length() > 0
      for i in 0..original_sorted_cards_key_array.length()-1
        san_zhang_card_array = Array.new
        dan_zhang_card_array = Array.new

        key = original_sorted_cards_key_array[i]
        result_cards = Card.get_cards_by_key(original_cards,key)

        if result_cards.length() >= 3
          for k in 0..2
            card = result_cards[k]
            san_zhang_card_array << card
          end
        elsif result_cards.length() != 0
          card = result_cards[0]
          dan_zhang_card_array << card
        end

        if 0 != san_zhang_card_array.length()
          san_zhang_optional_cards << san_zhang_card_array
        end

        if 0 != dan_zhang_card_array.length()
          dan_zhang_optional_cards << dan_zhang_card_array
        end
      end

      for i in 0..san_zhang_optional_cards.length()-1
        temp_composed_optional_cards = Array.new
        san_zhang_cards = san_zhang_optional_cards[i]
        for k in 0..san_zhang_cards.length()-1
          temp_composed_optional_cards << san_zhang_cards[k]
        end

        for j in 0..dan_zhang_optional_cards.length()-1
          composed_optional_cards = temp_composed_optional_cards.dup
          dan_zhang_cards = dan_zhang_optional_cards[j]
          for k in 0..dan_zhang_cards.length()-1
            composed_optional_cards << dan_zhang_cards[k]
          end

          if CardValidator.is_san_dai_yi_card_validate(composed_optional_cards)
            puts "自动三带一验证通过"
            for i in 0..composed_optional_cards.length()-1
              CardDebug.print_card_info(composed_optional_cards[i])
            end
            optional_cards << composed_optional_cards
          end
          next
        end
      end
    end

    return optional_cards
  end

  def self.get_auto_san_shun_bu_dai_larger_cards(original_cards)
    optional_cards = Array.new
    original_cards_map = Card.get_card_map(original_cards)

    original_cards_key_array = Array.new
    original_cards_map.each do |key,value|
      if value >= 3 && key >= 3 && key <= 14
        original_cards_key_array << key
      end
    end
    original_sorted_cards_key_array = CardSort.inc_sort_cards(original_cards_key_array)

    san_shun_optional_cards = Array.new
    san_zhang_optional_cards = Array.new
    if original_sorted_cards_key_array.length() > 0
      for i in 0..original_sorted_cards_key_array.length()-1
        san_zhang_card_array = Array.new
        key = original_sorted_cards_key_array[i]
        result_cards = Card.get_cards_by_key(original_cards,key)

        if result_cards.length() >= 3
          for k in 0..2
            card = result_cards[k]
            san_zhang_card_array << card
          end
        end

        if 0 != san_zhang_card_array.length()
          san_zhang_optional_cards << san_zhang_card_array
        end
      end

      tmp_san_zhang_optional_cards = Array.new
      for i in 0..san_zhang_optional_cards.length()-1
        if i == san_zhang_optional_cards.length()-1
          break
        end

        san_zhang_cards = san_zhang_optional_cards[i]
        next_san_zhang_cards = san_zhang_optional_cards[i+1]

        san_zhang_card_info = Card.get_card_info_from_integer(san_zhang_cards[0])
        next_san_zhang_card_info = Card.get_card_info_from_integer(next_san_zhang_cards[0])

        if tmp_san_zhang_optional_cards.empty?
          if san_zhang_card_info.card_number + 1 == next_san_zhang_card_info.card_number
            tmp_san_zhang_optional_cards = CardHelper.push_back_without_duplicate(tmp_san_zhang_optional_cards,san_zhang_cards)
            tmp_san_zhang_optional_cards = CardHelper.push_back_without_duplicate(tmp_san_zhang_optional_cards,next_san_zhang_cards)
          end
        else
          last_cards_object = tmp_san_zhang_optional_cards[tmp_san_zhang_optional_cards.length()-1]
          last_card_info = Card.get_card_info_from_integer(last_cards_object[0])

          if san_zhang_card_info.card_number + 1 == next_san_zhang_card_info.card_number && last_card_info.card_number == san_zhang_card_info.card_number
            tmp_san_zhang_optional_cards = CardHelper.push_back_without_duplicate(tmp_san_zhang_optional_cards,san_zhang_cards)
            tmp_san_zhang_optional_cards = CardHelper.push_back_without_duplicate(tmp_san_zhang_optional_cards,next_san_zhang_cards)
          else
            if tmp_san_zhang_optional_cards.length() < 2
              tmp_san_zhang_optional_cards.clear()
            end
          end

        end
      end

      san_shun_card_array = CardHelper.convert_cards_array_to_cards(tmp_san_zhang_optional_cards)
      san_shun_optional_cards << san_shun_card_array

      for i in 0..san_shun_optional_cards.length() - 1
        san_shun_cards = san_shun_optional_cards[i]

        if CardValidator.is_san_shun_bu_dai_card_validate(san_shun_cards)
          puts "三顺不带验证通过"
          for j in 0..san_shun_cards.length()-1
            CardDebug.print_card_info(san_shun_cards[j])
          end
          optional_cards << san_shun_cards
        end
      end
    end

    return optional_cards
  end

  def self.get_auto_san_shun_dai_dan_larger_cards(original_cards)
    optional_cards = Array.new
    original_cards_map = Card.get_card_map(original_cards)

    original_cards_key_array = Array.new
    original_cards_map.each do |key,value|
      if value >= 3 && key >= 3 && key <= 14
        original_cards_key_array << key
      elsif value >= 1 && key >= 3 && key <= 17
        original_cards_key_array << key
      end
    end
    original_sorted_cards_key_array = CardSort.inc_sort_cards(original_cards_key_array)

    san_shun_optional_cards = Array.new
    yi_zhang_optional_cards = Array.new

    san_zhang_optional_cards = Array.new
    dan_zhang_optional_cards = Array.new

    if original_sorted_cards_key_array.length() > 0
      for i in 0..original_sorted_cards_key_array.length()-1
        san_zhang_card_array = Array.new
        yi_zhang_card_array = Array.new

        key = original_sorted_cards_key_array[i]
        result_cards = Card.get_cards_by_key(original_cards,key)

        if result_cards.length() >= 3
          for k in 0..2
            card = result_cards[k]
            san_zhang_card_array << card
          end
        elsif result_cards.length() != 0
          card = result_cards[0]
          yi_zhang_card_array << card
        end

        if 0 != san_zhang_card_array.length()
          san_zhang_optional_cards << san_zhang_card_array
        end
        if 0 != yi_zhang_card_array.length()
          yi_zhang_optional_cards << yi_zhang_card_array
        end
      end

      tmp_san_zhang_optional_cards = Array.new
      for i in 0..san_zhang_optional_cards.length()-1
        if i == san_zhang_optional_cards.length()-1
          break
        end

        san_zhang_cards = san_zhang_optional_cards[i]
        next_san_zhang_cards = san_zhang_optional_cards[i+1]

        san_zhang_card_info = Card.get_card_info_from_integer(san_zhang_cards[0])
        next_san_zhang_card_info = Card.get_card_info_from_integer(next_san_zhang_cards[0])

        if tmp_san_zhang_optional_cards.empty?
          if san_zhang_card_info.card_number + 1 == next_san_zhang_card_info.card_number
            tmp_san_zhang_optional_cards = CardHelper.push_back_without_duplicate(tmp_san_zhang_optional_cards,san_zhang_cards)
            tmp_san_zhang_optional_cards = CardHelper.push_back_without_duplicate(tmp_san_zhang_optional_cards,next_san_zhang_cards)
          end
        else
          last_cards_object = tmp_san_zhang_optional_cards[tmp_san_zhang_optional_cards.length()-1]
          last_card_info = Card.get_card_info_from_integer(last_cards_object[0])

          if san_zhang_card_info.card_number + 1 == next_san_zhang_card_info.card_number && last_card_info.card_number == san_zhang_card_info.card_number
            tmp_san_zhang_optional_cards = CardHelper.push_back_without_duplicate(tmp_san_zhang_optional_cards,san_zhang_cards)
            tmp_san_zhang_optional_cards = CardHelper.push_back_without_duplicate(tmp_san_zhang_optional_cards,next_san_zhang_cards)
          else
            if tmp_san_zhang_optional_cards.length() < 2
              tmp_san_zhang_optional_cards.clear()
            end
          end

        end
      end

      san_shun_card_array = CardHelper.convert_cards_array_to_cards(tmp_san_zhang_optional_cards)
      san_shun_optional_cards << san_shun_card_array

      for i in 0..dan_zhang_optional_cards.length()-1
        tmp_dan_zhang_optional_cards = Array.new
        j = i
        for counter in 0..san_shun_optional_cards.length()-1
          if j == dan_zhang_optional_cards.length()
            j = 0
          else
            j+=1
          end

          dan_zhang_cards = dan_zhang_optional_cards[j]
          tmp_dan_zhang_optional_cards = CardHelper.push_back_without_duplicate(tmp_dan_zhang_optional_cards,dan_zhang_cards)
        end

        yi_zhang_card_array = CardHelper.convert_cards_array_to_cards(tmp_dan_zhang_optional_cards)
        yi_zhang_optional_cards << yi_zhang_card_array
      end

      for i in 0..san_shun_optional_cards.length() - 1
        temp_composed_optional_cards = Array.new
        san_shun_cards = san_shun_optional_cards[i]

        for k in 0..san_shun_cards.length()-1
          temp_composed_optional_cards << san_shun_cards[k]
        end

        for j in 0..yi_zhang_optional_cards.length()-1
          composed_optional_cards = temp_composed_optional_cards.dup
          yi_zhang_cards = yi_zhang_optional_cards[j]
          for k in 0..yi_zhang_cards.length()-1
            composed_optional_cards << yi_zhang_cards[k]
          end

          if CardValidator.is_san_shun_dai_dan_card_validate(composed_optional_cards)
            puts "三顺带单验证通过"
            for i in 0..composed_optional_cards.length()-1
              CardDebug.print_card_info(composed_optional_cards[i])
            end
            optional_cards << composed_optional_cards
          end
          next
        end
      end
    end

    return optional_cards
  end

  def self.get_auto_san_shun_dai_shuang_larger_cards(original_cards)
    optional_cards = Array.new
    original_cards_map = Card.get_card_map(original_cards)

    original_cards_key_array = Array.new
    original_cards_map.each do |key,value|
      if value >= 3 && key >= 3 && key <= 14
        original_cards_key_array << key
      elsif value >= 2 && key >= 3 && key <= 15
        original_cards_key_array << key
      end
    end
    original_sorted_cards_key_array = CardSort.inc_sort_cards(original_cards_key_array)

    san_shun_optional_cards = Array.new
    dui_zi_optional_cards = Array.new

    san_zhang_optional_cards = Array.new
    liang_zhang_optional_cards = Array.new

    if original_sorted_cards_key_array.length() > 0
      for i in 0..original_sorted_cards_key_array.length()-1
        san_zhang_card_array = Array.new
        dui_zi_card_array = Array.new

        key = original_sorted_cards_key_array[i]
        result_cards = Card.get_cards_by_key(original_cards,key)

        if result_cards.length() >= 3
          for k in 0..2
            card = result_cards[k]
            san_zhang_card_array << card
          end
        elsif result_cards.length() >= 2
          for k in 0..1
            card = result_cards[k]
            dui_zi_card_array << card
          end
        end

        if 0 != san_zhang_card_array.length()
          san_zhang_optional_cards << san_zhang_card_array
        end
        if 0 != dui_zi_card_array.length()
          liang_zhang_optional_cards << dui_zi_card_array
        end
      end

      tmp_san_zhang_optional_cards = Array.new
      for i in 0..san_zhang_optional_cards.length()-1
        if i == san_zhang_optional_cards.length()-1
          break
        end

        san_zhang_cards = san_zhang_optional_cards[i]
        next_san_zhang_cards = san_zhang_optional_cards[i+1]

        san_zhang_card_info = Card.get_card_info_from_integer(san_zhang_cards[0])
        next_san_zhang_card_info = Card.get_card_info_from_integer(next_san_zhang_cards[0])

        if tmp_san_zhang_optional_cards.empty?
          if san_zhang_card_info.card_number + 1 == next_san_zhang_card_info.card_number
            tmp_san_zhang_optional_cards = CardHelper.push_back_without_duplicate(tmp_san_zhang_optional_cards,san_zhang_cards)
            tmp_san_zhang_optional_cards = CardHelper.push_back_without_duplicate(tmp_san_zhang_optional_cards,next_san_zhang_cards)
          end
        else
          last_cards_object = tmp_san_zhang_optional_cards[tmp_san_zhang_optional_cards.length()-1]
          last_card_info = Card.get_card_info_from_integer(last_cards_object[0])

          if san_zhang_card_info.card_number + 1 == next_san_zhang_card_info.card_number && last_card_info.card_number == san_zhang_card_info.card_number
            tmp_san_zhang_optional_cards = CardHelper.push_back_without_duplicate(tmp_san_zhang_optional_cards,san_zhang_cards)
            tmp_san_zhang_optional_cards = CardHelper.push_back_without_duplicate(tmp_san_zhang_optional_cards,next_san_zhang_cards)
          else
            if tmp_san_zhang_optional_cards.length() < 2
              tmp_san_zhang_optional_cards.clear()
            end
          end
        end
      end

      san_shun_card_array = CardHelper.convert_cards_array_to_cards(tmp_san_zhang_optional_cards)
      san_shun_optional_cards << san_shun_card_array

      for i in 0..liang_zhang_optional_cards.length()-1
        dui_zi_card_array = liang_zhang_optional_cards[i]
        dui_zi_optional_cards << dui_zi_card_array
      end

      for i in 0..san_shun_optional_cards.length() - 1
        temp_composed_optional_cards = Array.new
        san_shun_cards = san_shun_optional_cards[i]

        for k in 0..san_shun_cards.length()-1
          temp_composed_optional_cards << san_shun_cards[k]
        end

        for j in 0..dui_zi_optional_cards.length()-1
          composed_optional_cards = temp_composed_optional_cards.dup
          dui_zi_cards = dui_zi_optional_cards[j]
          for k in 0..dui_zi_cards.length()-1
            composed_optional_cards << dui_zi_cards[k]
          end
        end
        if CardValidator.is_san_shun_dai_shuang_card_validate(composed_optional_cards)
          puts "三顺带双验证通过"
          for i in 0..composed_optional_cards.length()-1
            CardDebug.print_card_info(composed_optional_cards[i])
          end
          optional_cards << composed_optional_cards
        end
      end
    end

    return optional_cards
  end

  def self.get_auto_san_zhang_larger_cards(original_cards)
    optional_cards = Array.new
    original_cards_map = Card.get_card_map(original_cards)

    original_cards_key_array = Array.new
    original_cards_map.each do |key,value|
      if value >= 3 && key >= 3 && key <= 15
        original_cards_key_array << key
      end
    end
    original_sorted_cards_key_array = CardSort.inc_sort_cards(original_cards_key_array)

    san_zhang_optional_cards = Array.new
    if original_sorted_cards_key_array.length() > 0
      for i in 0..original_sorted_cards_key_array.length()-1
        san_zhang_card_array = Array.new

        key = original_sorted_cards_key_array[i]
        result_cards = Card.get_cards_by_key(original_cards,key)

        if result_cards.length() >= 3
          for k in 0..2
            card = result_cards[k]
            san_zhang_card_array << card
          end
        end

        if 0 != san_zhang_card_array.length()
          san_zhang_optional_cards << san_zhang_card_array
        end
      end

      for i in 0..san_zhang_optional_cards.length()-1
        san_zhang_cards = san_zhang_optional_cards[i]
        if CardValidator.is_san_zhang_card_validate(san_zhang_cards)
          puts "自动三张验证通过"
          for j in 0..san_zhang_cards.length()-1
            CardDebug.print_card_info(san_zhang_cards[j])
          end
          optional_cards << san_zhang_cards
        end
      end
    end

    return optional_cards
  end

  def self.get_auto_shuang_shun_larger_cards(original_cards)
    optional_cards = Array.new
    original_cards_map = Card.get_card_map(original_cards)

    original_cards_key_array = Array.new
    original_cards_map.each do |key,value|
      if value >= 2 && key >= 3 && key <= 14
        original_cards_key_array << key
      end
    end
    original_sorted_cards_key_array = CardSort.inc_sort_cards(original_cards_key_array)

    shuang_shun_optional_cards = Array.new
    liang_zhang_optional_cards = Array.new
    if original_sorted_cards_key_array.length() > 0
      for i in 0..original_sorted_cards_key_array.length()-1
        liang_zhang_card_array = Array.new
        key = original_sorted_cards_key_array[i]
        result_cards = Card.get_cards_by_key(original_cards,key)

        if result_cards.length() >= 2
          for k in 0..1
            card = result_cards[k]
            liang_zhang_card_array << card
          end
        end

        if 0 != liang_zhang_card_array.length()
          liang_zhang_optional_cards << liang_zhang_card_array
        end
      end

      tmp_liang_zhang_optional_cards = Array.new
      for i in 0..liang_zhang_optional_cards.length()-1
        if i == liang_zhang_optional_cards.length()-1
          break
        end

        liang_zhang_cards = liang_zhang_optional_cards[i]
        next_liang_zhang_cards = liang_zhang_optional_cards[i+1]

        liang_zhang_card_info = Card.get_card_info_from_integer(liang_zhang_cards[0])
        next_liang_zhang_card_info = Card.get_card_info_from_integer(next_liang_zhang_cards[0])

        if tmp_liang_zhang_optional_cards.empty?
          if liang_zhang_card_info.card_number + 1 == next_liang_zhang_card_info.card_number
            tmp_liang_zhang_optional_cards = CardHelper.push_back_without_duplicate(tmp_liang_zhang_optional_cards,liang_zhang_cards)
            tmp_liang_zhang_optional_cards = CardHelper.push_back_without_duplicate(tmp_liang_zhang_optional_cards,next_liang_zhang_cards)
          end
        else
          last_cards_object = tmp_liang_zhang_optional_cards[tmp_liang_zhang_optional_cards.length()-1]
          last_card_info = Card.get_card_info_from_integer(last_cards_object[0])

          if liang_zhang_card_info.card_number + 1 == next_liang_zhang_card_info.card_number && last_card_info.card_number == liang_zhang_card_info.card_number
            tmp_liang_zhang_optional_cards = CardHelper.push_back_without_duplicate(tmp_liang_zhang_optional_cards,liang_zhang_cards)
            tmp_liang_zhang_optional_cards = CardHelper.push_back_without_duplicate(tmp_liang_zhang_optional_cards,next_liang_zhang_cards)
          else
            if tmp_liang_zhang_optional_cards.length() < 3
              tmp_liang_zhang_optional_cards.clear()
            end
          end

        end
      end

      shuang_shun_card_array = CardHelper.convert_cards_array_to_cards(tmp_liang_zhang_optional_cards)
      shuang_shun_optional_cards << shuang_shun_card_array

      for i in 0..shuang_shun_optional_cards.length() - 1
        shuang_shun_cards = shuang_shun_optional_cards[i]

        if CardValidator.is_shuang_shun_card_validate(shuang_shun_cards)
          puts "双顺验证通过"
          for j in 0..shuang_shun_cards.length()-1
            CardDebug.print_card_info(shuang_shun_cards[j])
          end
          optional_cards << shuang_shun_cards
        end
      end
    end

    return optional_cards
  end

  def self.get_auto_wang_zha_larger_cards(original_cards)
    optional_cards = Array.new
    result_cards = Array.new
    for i in 0..original_cards.length()-1
      card_info = Card.get_card_info_from_integer(original_cards[i])
      if card_info.card_type == CardTypeConst::CardType::WANG
        result_cards << original_cards[i]
      end
    end
    optional_cards << result_cards

    if result_cards.length() != 2
      optional_cards.clear()
    end
    return optional_cards
  end

  def self.get_auto_zha_dan_larger_cards(original_cards)
    optional_cards = Array.new
    original_cards_map = Card.get_card_map(original_cards)

    original_cards_key_array = Array.new
    original_cards_map.each do |key,value|
      if value == 4 && key >= 3 && key <= 15
        original_cards_key_array << key
      end
    end
    original_sorted_cards_key_array = CardSort.inc_sort_cards(original_cards_key_array)

    si_zhang_optional_cards = Array.new
    if original_sorted_cards_key_array.length() > 0
      for i in 0..original_sorted_cards_key_array.length()-1
        si_zhang_card_array = Array.new

        key = original_sorted_cards_key_array[i]
        result_cards = Card.get_cards_by_key(original_cards,key)

        if result_cards.length() >= 4
          for k in 0..3
            card = result_cards[k]
            si_zhang_card_array << card
          end
        end

        if 0 != si_zhang_card_array.length()
          si_zhang_optional_cards << si_zhang_card_array
        end
      end

      for i in 0..si_zhang_optional_cards.length()-1
        si_zhang_cards = si_zhang_optional_cards[i]
        if CardValidator.is_zha_dan_card_validate(si_zhang_cards)
          puts "自动炸弹验证通过"
          for j in 0..si_zhang_cards.length()-1
            CardDebug.print_card_info(si_zhang_cards[j])
          end
          optional_cards << si_zhang_cards
        end
      end
    end

    return optional_cards
  end
end
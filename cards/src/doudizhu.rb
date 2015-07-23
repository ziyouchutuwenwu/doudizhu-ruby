require 'erlectricity'

require_relative 'card/card'
require_relative 'card/card_compare'
require_relative 'card/card_validator'
require_relative 'card/card_prompt'
require_relative 'card/card_prompt_type'

receive do |f|

    # 洗牌
    f.when([:wash_card, Array]) do |_arr|
      cards = Card.wash_card
      f.send!(cards)
      f.receive_loop
    end

    # 校验牌是否有效
    f.when([:is_card_validate, Any]) do |params|
      cards = params[0]
      result = CardValidator.is_card_validate(cards)
      f.send!(result)
      f.receive_loop
    end

    # 新出的牌和原来的牌比大小
    f.when([:is_new_cards_larger, Any]) do |params|
      new_cards = params[0]
      old_cards = params[1]
      result = CardCompare.is_new_cards_larger(new_cards,old_cards)
      f.send!(result)
      f.receive_loop
    end

    # 从手里获取可以出的牌
    f.when([:get_auto_larger_cards, Any]) do |params|
      cards = params[0]
      result = CardAutoPrompt.get_auto_larger_cards(cards)
      f.send!(result)
      f.receive_loop
    end

    # 根据原来的牌，从手里找出比它们大的牌
    f.when([:get_new_larger_cards, Any]) do |params|
      cards = params[0]
      cards_from_user = params[1]
      result = CardPrompt.get_new_larger_cards(cards,cards_from_user)
      f.send!(result)
      f.receive_loop
    end

    # 获取牌的类型，返回飞机，顺子，火箭，炸弹
    # 单张，对子，三个，三带一，三带二
    f.when([:get_card_prompt_type, Any]) do |params|
      cards = params[0]
      result = CardPromptType.get_cards_type(cards)
      f.send!(result)
      f.receive_loop
    end

end
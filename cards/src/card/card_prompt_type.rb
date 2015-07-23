require_relative 'card_validator'

# 飞机：三顺不带，三顺带单，三顺带双
# 顺子：单顺，双顺
# 火箭：王炸
# 炸弹：炸弹
# 单张
# 对子
# 三个
# 三带一
# 三带二

class CardPromptType

  INVALID_CARD_TYPE = -1
  FEI_JI = 1
  SHUN_ZI = 2
  HUO_JIAN = 3
  ZHA_DAN = 4
  DAN_ZHNAG = 5
  DUI_ZI = 6
  SAN_ZHANG = 7
  SAN_DAI_YI = 8
  SAN_DAI_ER = 9

  def self.get_cards_type(cards)
    cards_type = INVALID_CARD_TYPE

    if is_fei_ji(cards)
      cards_type = FEI_JI
    elsif is_shun_zi(cards)
      cards_type = SHUN_ZI
    elsif is_huo_jian(cards)
      cards_type = HUO_JIAN
    elsif is_zha_dan(cards)
      cards_type = ZHA_DAN
    elsif is_dan_zhang(cards)
      cards_type = DAN_ZHNAG
    elsif is_dui_zi(cards)
      cards_type = DUI_ZI
    elsif is_san_zhang(cards)
      cards_type = SAN_ZHANG
    elsif is_san_dai_yi(cards)
      cards_type = SAN_DAI_YI
    elsif is_san_dai_er(cards)
      cards_type = SAN_DAI_ER
    end

    return cards_type
  end

  def self.is_fei_ji(cards)
    result = false

    if !result
      result = CardValidator.is_san_shun_dai_dan_card_validate(cards)
    end

    if !result
      result = CardValidator.is_san_shun_dai_dan_card_validate(cards)
    end

    if !result
      result = CardValidator.is_san_shun_dai_shuang_card_validate(cards)
    end

    return result
  end

  def self.is_shun_zi(cards)
    result = false

    if !result
      result = CardValidator.is_dan_shun_card_validate(cards)
    end

    if !result
      result = CardValidator.is_shuang_shun_card_validate(cards)
    end

    return result
  end

  def self.is_huo_jian(cards)
    return CardValidator.is_wang_zha_card_validate(cards)
  end

  def self.is_zha_dan(cards)
    return CardValidator.is_zha_dan_card_validate(cards)
  end

  def self.is_dan_zhang(cards)
    return CardValidator.is_dan_zhang_card_validate(cards)
  end

  def self.is_dui_zi(cards)
    return CardValidator.is_dui_zi_card_validate(cards)
  end

  def self.is_san_zhang(cards)
    return CardValidator.is_san_zhang_card_validate(cards)
  end

  def self.is_san_dai_yi(cards)
    return CardValidator.is_san_dai_yi_card_validate(cards)
  end

  def self.is_san_dai_er(cards)
    return CardValidator.is_san_dai_er_card_validate(cards)
  end

end
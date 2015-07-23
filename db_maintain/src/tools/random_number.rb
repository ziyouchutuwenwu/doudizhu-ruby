module RandomNumber
  def self.get_random_number
    srand()

    min = 10**15
    max = 10**16 -1
    delta = min - 1
    rand(max - delta) + delta
  end

  def self.now_to_number
    Time.now.to_i
  end
end
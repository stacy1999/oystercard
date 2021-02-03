class Oystercard
  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1

  attr_reader :balance
  attr_reader :in_journey
  
  
  def initialize 
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    raise "Cannot exceed #{MAXIMUM_BALANCE} balance" if (amount + @balance) > MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in
    fail "Insufficient balance" if @balance < MINIMUM_FARE
    @in_journey = true
  end

  def touch_out
    deduct(MINIMUM_FARE)
    @in_journey = false

  end

 private
 
  def deduct(amount)
    @balance -= amount
  end
end
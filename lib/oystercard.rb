require_relative 'station'
require_relative 'journey'
class Oystercard
  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1

  attr_reader :balance, :entry_station, :journeys
  
  def initialize 
    @journey = Journey.new
    @balance = 0
    # @entry_station = nil
    # @journeys = []
  end

  def top_up(amount)
    raise "Cannot exceed #{MAXIMUM_BALANCE} balance" if (amount + @balance) > MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in(station)
    fail "Insufficient balance" if @balance < MINIMUM_FARE
    @journey.start_journey(station)
    #@entry_station = station
  end

  def touch_out(exit_station)
    deduct(MINIMUM_FARE)
    @journey.end_journey(exit_station)
    # @journeys.push({ entry: @entry_station, exit: exit_station })
    # @entry_station = nil
  end

  def journey
    @journey.journeys
    
  end

  def in_journey?
    if @entry_station == nil
      false
    else
      true
    end
  end

 private
 
  def deduct(amount)
    @balance -= amount
  end
end
#it should be responsible for starting a journey,
# finishing a journey, calculating the fare of a journey, 
#and returning whether or not the journey is complete.
require_relative 'oystercard'

class Journey
  attr_reader :journeys

  def initialize
    @entry_station = nil
    @journeys = []
  end
  
  def start_journey(station)
    @entry_station = station
  end

  def end_journey(exit_station)
    @journeys.push({ entry: @entry_station, exit: exit_station })
    @entry_station = nil
  end

  def fare
    
  end

end
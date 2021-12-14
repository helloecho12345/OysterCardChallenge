class Oystercard

  attr_reader :balance
  attr_reader :entry_station
  attr_accessor :journey

  MAXIMUM_BALANCE = 90
  MINIMUM_AMOUNT = 1

  def initialize
    @balance = 0
    @journey = []
  end

  def top_up(amount)
    
  fail "Maximum balance reached" if amount + balance > MAXIMUM_BALANCE
   @balance += amount
  end

  def deduct(fare)
    @balance -= fare
  end
  
  def touch_in(station)
    if @balance >= MINIMUM_AMOUNT
      @entry_station = station
      @journey.push(@entry_station)
    else 
      fail "You don't have the minimum amount"
    end

  end

  def touch_out(station)
    self.deduct(1)
    @exit_station = station
    record_journey
    @entry_station = nil
  end
  
  def in_journey?
    @entry_station
  end

  def record_journey
    @journey << { entry: @entry_station, exit: @exit_station }
  end

  private :deduct
  

end
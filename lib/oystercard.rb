class Oystercard

  attr_reader :balance
  attr_reader :entry_station

  MAXIMUM_BALANCE = 90
  MINIMUM_AMOUNT = 1

  def initialize
    @balance = 0
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
      @in_journey = true
      @entry_station = station
    else 
      fail "You don't have the minimum amount"
    end

  end

  def touch_out
    @in_journey = false
    self.deduct(1)
    @entry_station = nil
  end
  
  def in_journey?
    @entry_station
  end

  private :deduct
  
end
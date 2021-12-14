require 'oystercard'

describe Oystercard do
  let(:station) { double :station }

  it "has a balance of zero" do  
   expect(subject.balance).to eq(0)
  end

  it "adds money to the oystercard" do
    expect(subject).to respond_to(:top_up) 
  end

  it "has a maximum limit of £90" do
    maximum_balance = Oystercard::MAXIMUM_BALANCE
    subject.top_up(maximum_balance)
    expect{ subject.top_up(1) }.to raise_error "Maximum balance reached"
  end

  it "deducts fare from the oystercard balance" do
    subject.top_up(20)
    expect{ subject.send(:deduct, 3) }.to change{ subject.balance }.by -3
  end

  it "lets the customer in through the barriers" do
    expect(subject).to respond_to(:touch_in)
  end


  it "lets the customer out through the barriers" do
    expect(subject).to respond_to(:touch_out)
  end

  it { is_expected.to respond_to 'in_journey?' }

  it "checks MINIMUM_AMOUNT" do
    expect(Oystercard::MINIMUM_AMOUNT).to eq 1
  end

  it "needs a MINIMUM_AMOUNT" do
    expect{ subject.touch_in(station) }.to raise_error "You don't have the minimum amount"
  end

  it "deducts the fare from the oystercard when it touches out" do
    subject.top_up(20)
    expect{ subject.touch_out(station) }.to change{ subject.balance }.by(-1)
  end

  it "records entry station at touch_in" do 
    subject.top_up(20)
    subject.touch_in(station)
    expect(subject.entry_station).to eq station
  end

  it "forgets the entry station at touch_out" do 
    subject.top_up(20)
    subject.touch_out(station)
    expect(subject.entry_station).to eq nil
  end

  it "check for journey empty array" do
    expect(subject.journey).to eq []
  end

  it "checks if journey is created" do
    subject.top_up(20)
    subject.touch_in(station)
    subject.touch_out(station)
    expect(subject.journey).to_not eq []
  end

end
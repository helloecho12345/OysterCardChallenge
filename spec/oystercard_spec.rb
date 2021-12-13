require 'oystercard'

describe Oystercard do

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
    expect{ subject.deduct 3}.to change{ subject.balance }.by -3
    expect(subject).to respond_to(:deduct).with(1).argument
  end

  it "lets the customer in through the barriers" do
    expect(subject).to respond_to(:touch_in)
  end


  it "lets the customer out through the barriers" do
    expect(subject).to respond_to(:touch_out)
  end

  it { is_expected.to respond_to 'in_journey?' }
end
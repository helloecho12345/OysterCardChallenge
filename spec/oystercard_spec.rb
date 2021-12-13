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
end
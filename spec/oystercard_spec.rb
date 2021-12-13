require 'oystercard'

describe Oystercard do

  it "has a balance of zero" do  
   expect(subject.balance).to eq(0)
  end

  it "adds money to the oystercard" do
    expect(subject).to respond_to(:top_up) 
  end
end
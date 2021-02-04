require 'oystercard'
describe Oystercard do
  let(:station) { double }
  let(:exit_station) { double }

  it 'returns an empty list of journey' do
    expect(subject.journeys).to eq([])
  end

  it 'returns initial balance on .balance call' do
    expect(subject.balance).to eq(0)
  end

  
  describe '#top_up' do
    it 'adds money into your oystercard' do
      subject.top_up(10)
      expect(subject.balance).to eq(10)
    end
    it 'restricts from exceeding the oystercard limit balance' do
      maximum_balance = Oystercard::MAXIMUM_BALANCE
      subject.top_up(maximum_balance)
      expect { subject.top_up(1) }.to raise_error "Cannot exceed #{maximum_balance} balance"
    end
  end
  
  # describe '#deduct' do
  #   it "deducts money from your balance" do
  #     subject.top_up(20)
  #     # subject.deduct(5)
  #     # expect(subject.balance).to eq(15)
  #     expect{ subject.deduct(3)}.to change{ subject.balance }.by (-3)
  #   end
  # end
  
  # describe '@in_journey' do
  #   it "returns not in a journey" do
  #     expect(subject.in_journey).to eq(false)
  #   end
  # end

  describe '#touch_in' do
    context "balance is less than one" do
      it "will not touch in if card doesn't have a minimum balance of £1" do
        expect { subject.touch_in(station) }.to raise_error "Insufficient balance"
      end
    end
    # context "user wants to touch in" do
    #   # it "changes the state to be in a journey" do
    #   #   subject.top_up(Oystercard::MINIMUM_FARE)
    #   #   subject.touch_in(station)
    #   #   expect(subject.in_journey).to eq(true)
    #   # end
    # end
    it "stores the entry station" do
      subject.top_up(Oystercard::MINIMUM_FARE)
      subject.touch_in(station)
      expect(subject.entry_station).to eq(station)
    end
  end

  describe '#touch_out' do
    # it "changes the state to be out of a journey" do
    #   subject.touch_out
    #   expect(subject.in_journey).to eq(false)
    # end
    it "charges the balance by minimum fare" do
      subject.top_up(Oystercard::MINIMUM_FARE)
      subject.touch_in(station)
      expect{ subject.touch_out(exit_station) }.to change{ subject.balance }.by (-Oystercard::MINIMUM_FARE)
    end
    it "forgets the entry station" do
      subject.top_up(Oystercard::MINIMUM_FARE)
      subject.touch_in(station)
      subject.touch_out(exit_station)
      expect(subject.entry_station).to eq(nil)
    end
  end
  
  it 'creates a journey by touching in and out' do
    subject.top_up(Oystercard::MINIMUM_FARE)
    subject.touch_in(station)
    subject.touch_out(exit_station)
    expect(subject.journeys).to eq([{ entry: station, exit: exit_station }])
  end
  describe '#in_journey?' do
    it "returns true if on a journey" do
      subject.top_up(Oystercard::MINIMUM_FARE)
      subject.touch_in(station)
      expect(subject.in_journey?).to eq(true)
    end

    it "returns false when not on a journey" do
      subject.top_up(Oystercard::MINIMUM_FARE)
      subject.touch_in(station)
      subject.touch_out(exit_station)
      expect(subject.in_journey?).to eq(false)
    end
  end
end
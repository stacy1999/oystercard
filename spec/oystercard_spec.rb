require 'oystercard'
describe Oystercard do
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
      expect { subject.top_up(1) }.to raise_error 'Cannot exceed 90 balance'
    end
  end
  
  describe '#deduct' do
    it "deducts money from your oystercard" do
      subject.top_up(20)
      subject.deduct(5)
      expect(subject.balance).to eq(15)
    end
  end
  
  describe '@in_journey' do
    it "returns not in a journey" do
      expect(subject.in_journey).to eq(false)
    end
  end

  describe '#touch_in' do
    it "change the state to be in a journey" do
      subject.touch_in
      expect(subject.in_journey).to eq(true)
    end
  end

  describe '#touch_out' do
    it "change the state to be out f a journey" do
      subject.touch_in
      subject.touch_out
      expect(subject.in_journey).to eq(false)
    end
  end

end
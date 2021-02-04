require 'station'

describe Station do
  
  #subject {described_class.new(name: "Old Street", zone: 1)}

  it 'knows its name' do
    station = Station.new("Old Street", 1)
    expect(station.name).to eq("Old Street")
  end

  it 'knows its zone' do
    station = Station.new("Old Street", 1)
    expect(station.zone).to eq(1)
  end
end


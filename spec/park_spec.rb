require './lib/trail'
require './lib/park'
require './lib/hiker'
require 'date'

RSpec.describe Park do
  describe '#initialize' do
    it 'exists' do
      park1 = Park.new('Capitol Reef')

      expect(park1).to be_a(Park)
    end

    it 'has attributes' do
      park1 = Park.new('Capitol Reef')

      expect(park1.name).to eq('Capitol Reef')
      expect(park1.trails).to eq([])
    end
  end

  describe '#add_trail' do
    it 'can add trails' do
      park1 = Park.new('Capitol Reef')
      trail1 = Trail.new({name: 'Grand Wash',
                          length: '2.2 miles',
                          level: :easy})
      trail2 = Trail.new({name: 'Cohab Canyon',
                          length: '1.7 miles',
                          level: :moderate})

                          park1.add_trail(trail1)
      park1.add_trail(trail2)

      expect(park1.trails).to eq([trail1, trail2])

      trail3 = Trail.new({name: 'Tower Bridge',
                          length: '3.0 miles',
                          level: :moderate})
      park2 = Park.new('Bryce Canyon')

      park2.add_trail(trail3)

      expect(park2.trails).to eq([trail3])
    end
  end

  describe '#trails_shorter_than' do
    it 'can list the trails shorter than length given' do
      trail1 = Trail.new({name: 'Grand Wash',
                          length: '2.2 miles',
                          level: :easy})
      trail2 = Trail.new({name: 'Cohab Canyon',
                          length: '1.7 miles',
                          level: :moderate})
      trail3 = Trail.new({name: 'Chimney Rock Loop',
                          length: '3.6 miles',
                          level: :strenuous})
      trail4 = Trail.new({name: "Queen's/Navajo Loop",
                          length: '2.9 miles',
                          level: :moderate})
      trail5 = Trail.new({name: 'Rim Trail',
                          length: '11 miles',
                          level: :easy})
      trail6 = Trail.new({name: 'Tower Bridge',
                          length: '3 miles',
                          level: :moderate})
      park1 = Park.new('Capitol Reef')
      park2 = Park.new('Bryce Canyon')
      park1.add_trail(trail1)
      park1.add_trail(trail2)
      park1.add_trail(trail3)
      park2.add_trail(trail4)
      park2.add_trail(trail5)
      park2.add_trail(trail6)
      hiker = Hiker.new('Dora', :moderate)
      hiker.visit(park1)
      hiker.visit(park2)

      expect(park1.trails_shorter_than(2.5)).to eq([trail1, trail2])
      expect(park2.trails_shorter_than(2.5)).to eq([])
    end
  end

  describe "#hikeable_miles" do
    it 'returns the total amount of trail miles' do
      trail1 = Trail.new({name: 'Grand Wash',
                          length: '2.2 miles',
                          level: :easy})
      trail2 = Trail.new({name: 'Cohab Canyon',
                          length: '1.7 miles',
                          level: :moderate})
      trail3 = Trail.new({name: 'Chimney Rock Loop',
                          length: '3.6 miles',
                          level: :strenuous})
      trail4 = Trail.new({name: "Queen's/Navajo Loop",
                          length: '2.9 miles',
                          level: :moderate})
      trail5 = Trail.new({name: 'Rim Trail',
                          length: '11 miles',
                          level: :easy})
      trail6 = Trail.new({name: 'Tower Bridge',
                          length: '3 miles',
                          level: :moderate})
      park1 = Park.new('Capitol Reef')
      park2 = Park.new('Bryce Canyon')
      park1.add_trail(trail1)
      park1.add_trail(trail2)
      park1.add_trail(trail3)
      park2.add_trail(trail4)
      park2.add_trail(trail5)
      park2.add_trail(trail6)
      hiker = Hiker.new('Dora', :moderate)
      hiker.visit(park1)
      hiker.visit(park2)

      expect(park1.hikeable_miles).to eq(7.5)
      expect(park2.hikeable_miles).to eq(16.9)
    end
  end

  describe '#trails_by_level' do
    it 'returns hash of trails by level' do
      trail1 = Trail.new({name: 'Grand Wash', length: '2.2 miles', level: :easy})
      trail2 = Trail.new({name: 'Cohab Canyon', length: '1.7 miles', level: :moderate})
      trail3 = Trail.new({name: 'Chimney Rock Loop', length: '3.6 miles', level: :strenuous})
      trail4 = Trail.new({name: "Queen's/Navajo Loop", length: '2.9 miles', level: :moderate})
      trail5 = Trail.new({name: 'Rim Trail', length: '11 miles', level: :easy})
      trail6 = Trail.new({name: 'Tower Bridge', length: '3 miles', level: :moderate})
      park1 = Park.new('Capitol Reef')
      park2 = Park.new('Bryce Canyon')
      park1.add_trail(trail1)
      park1.add_trail(trail2)
      park1.add_trail(trail3)
      park2.add_trail(trail4)
      park2.add_trail(trail5)
      park2.add_trail(trail6)

      expect(park1.trails_by_level).to eq(
        {
          :easy => ["Grand Wash"],
          :moderate => ["Cohab Canyon"],
          :strenuous => ["Chimney Rock Loop"]
        })
      expect(park2.trails_by_level).to eq(
        {
          :moderate => ["Queen's/Navajo Loop", "Tower Bridge"],
          :easy => ["Rim Trail"]
        })
    end
  end

  describe '#visitors_log' do
    xit 'lists the dates and parks the hiker visited' do
      trail1 = Trail.new({name: 'Rim Trail', length: '11 miles', level: :easy})
      trail2 = Trail.new({name: "Queen's/Navajo Loop", length: '2.9 miles', level: :moderate})
      trail3 = Trail.new({name: 'Tower Bridge', length: '3 miles', level: :moderate})
      trail4 = Trail.new({name: 'Peekaboo Loop', length: '5.5 miles', level: :strenuous})
      park = Park.new('Bryce Canyon')
      park.add_trail(trail1)
      park.add_trail(trail2)
      park.add_trail(trail3)
      park.add_trail(trail4)
      hiker1 = Hiker.new('Dora', :moderate)
      hiker2 = Hiker.new('Frank', :easy)
      hiker3 = Hiker.new('Jack', :strenuous)
      hiker4 = Hiker.new('Sally', :strenuous)
      allow(park).to receive(:visitor) do
        hiker1
      end
      hiker1.visit(park)
      allow(hiker2).to receive(:visit) do
        1980-06-24
      end
      hiker2.visit(park)
      allow(hiker3).to receive(:visit) do
        1980-06-24
      end
      hiker3.visit(park)
      allow(hiker4).to receive(:visit) do
        1980-06-25
      end
      hiker4.visit(park)
      allow(hiker1).to receive(:visit) do
        2020-06-23
      end
      hiker1.visit(park)
      allow(hiker1).to receive(:visit) do
        2020-06-24
      end
      hiker2.visit(park)
      allow(hiker1).to receive(:visit) do
        2020-06-24
      end
      hiker3.visit(park)
      allow(hiker1).to receive(:visit) do
        2020-06-25
      end
      hiker4.visit(park)

      expect(park.visitors_log).to eq(
        {
          1980 => {
            "06/23" => {
              hiker1 => [trail2, trail3]
            },
            "06/24" => {
              hiker2 => [trail1],
              hiker3 => [trail4]
            },
            "06/25" => {
              hiker4 => [trail4]
            }
          },
          2020 => {
            "06/23" => {
              hiker1 => [trail2, trail3]
            },
            "06/24" => {
              hiker2 => [trail1],
              hiker3 => [trail4]
            },
            "06/25" => {
              hiker4 => [trail4]
            }
          },
        })
    end
  end
end
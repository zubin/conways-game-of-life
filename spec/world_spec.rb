require 'spec_helper'
require 'pry'
require './world'

describe World do
  context "lone cell" do
    # [ ][x][ ]
    # [ ][ ][ ]
    # [ ][ ][ ]
    before do
      subject.add(0,1)
      subject.tick
    end
    it { subject.should_not be_active_at(0,1) }
  end

  context "with neighbours" do
    # [x][x][ ]
    # [x][ ][ ]
    # [x][ ][ ]
    before do
      subject.add(0,0)
      subject.add(0,1)
      subject.add(1,0)
      subject.add(0,2)
      subject.tick
    end
    it { subject.should be_active_at(0,0) }
    it { subject.should be_active_at(0,1) }
    it { subject.should be_active_at(1,0) }
    it { subject.should_not be_active_at(0,2) }
  end

  context "when crowded" do
    # [x][x][ ]
    # [x][x][ ]
    # [x][ ][ ]
    before do
      subject.add(0,0)
      subject.add(0,1)
      subject.add(1,0)
      subject.add(1,1)
      subject.add(0,2)
      subject.tick
    end
    it { subject.should be_active_at(0,0) }
    it { subject.should_not be_active_at(0,1) }
    it { subject.should be_active_at(1,0) }
    it { subject.should_not be_active_at(1,1) }
    it { subject.should be_active_at(0,2) }
  end
  
  context 'when three neighbours are active' do
    # [x][x][ ]
    # [x][ ][ ]
    # [ ][ ][ ]
    before do
      subject.add(0,0)
      subject.add(0,1)
      subject.add(1,0)
      subject.tick
    end
       
    it { subject.should be_active_at(1,1) }
  end
end
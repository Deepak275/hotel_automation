require 'spec_helper'

module HotelAutomation
  RSpec.describe Power do
    describe "#check_and_reset_hotel_consumption" do
      context "if power consumption exceeds power limt" do
        let(:floor1) { HotelAutomation::Floor.new(1, 1)  } 
        let(:floor2) { HotelAutomation::Floor.new(1, 1)  } 
        let(:power) { HotelAutomation::Power.new([floor1])  }
        let(:expected_output) { "  Main Corridor 1 \n     Light 1: ON\n     AC 1: ON\n  Sub Corridor 1 \n     Light 1: ON\n     AC 1: OFF\n  Max permissible for this floor: 25\n  Current Power consumption: 20\n" } 

        it 'should set the status of appliances accordingly' do
          floor1.sub_corridors.first.lights.first.turn_on
          power.check_and_reset_hotel_consumption
          expect(power.floor_current_status(floor1)).to eq(expected_output)
        end
      end
      
      context "if power consumtion is less than max power" do
        let(:floor) { HotelAutomation::Floor.new(1, 1)  } 
        let(:power) { HotelAutomation::Power.new([floor])  }
        let(:expected_output) { "  Main Corridor 1 \n     Light 1: ON\n     AC 1: ON\n  Sub Corridor 1 \n     Light 1: OFF\n     AC 1: ON\n  Max permissible for this floor: 25\n  Current Power consumption: 25\n" } 

        it "description" do
          power.check_and_reset_hotel_consumption
          expect(power.floor_current_status(floor)).to eq(expected_output)
        end
      end
    end

    describe '#floor_current_status' do
      let(:expected_output) { "  Main Corridor 1 \n     Light 1: ON\n     AC 1: ON\n  Sub Corridor 1 \n     Light 1: OFF\n     AC 1: OFF\n  Max permissible for this floor: 25\n  Current Power consumption: 15\n" } 
      it "should return the current status of appliances of floor" do
        floor = HotelAutomation::Floor.new(1, 1)
        power = HotelAutomation::Power.new([floor])

        expect(power.floor_current_status(floor)).to eq(expected_output)
      end
    end
  end
end
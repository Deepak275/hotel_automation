require 'spec_helper'

module HotelAutomation
  RSpec.describe Floor do
    describe "#current_status" do
      let(:expected_output) { "  Main Corridor 1 \n     Light 1: ON\n     AC 1: ON\n  Sub Corridor 1 \n     Light 1: OFF\n     AC 1: OFF\n  Max permissible for this floor: 25\n  Current Power consumption: 15\n" } 
      it "should return the current status of appliances of corridor" do
        floor = HotelAutomation::Floor.new(1, 1)
        power = HotelAutomation::Power.new([floor])
        expect(power.floor_current_status(floor)).to eq(expected_output)
      end
    end
  end
end
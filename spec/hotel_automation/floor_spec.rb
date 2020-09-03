require 'spec_helper'

module HotelAutomation
  RSpec.describe Floor do
    describe "#current_status" do
      let(:expected_output) { "  Main Corridor 1 \n     Light 1: ON\n     AC 1: ON\n  Sub Corridor 1 \n     Light 1: OFF\n     AC 1: ON\n  Max permissible for this floor: 25\n  Current Power consumption: 25\n" } 
      it "should return the current status of appliances of corridor" do
        floor = HotelAutomation::Floor.new(1, 1)

        expect(floor.current_status).to eq(expected_output)
      end
    end

    
    describe "#check_and_reset_power" do
      context "when power consumtion is equal max power" do
        it "should not change anything" do
          floor = HotelAutomation::Floor.new(1, 1)
          sub_corridors = floor.sub_corridors.first
          ac_intial_state = sub_corridors.air_conditioners.first.status

          floor.check_and_reset_power
          ac_new_status = sub_corridors.air_conditioners.first.status
          expect(ac_new_status).to eq(ac_intial_state)
        end
      end

      context "when power consumtion is less max power" do
        it "should turn on the ac" do
          floor = HotelAutomation::Floor.new(1, 1)
          sub_corridors = floor.sub_corridors.first
          sub_corridors.air_conditioners.first.turn_off

          floor.check_and_reset_power
          final_ac_status = sub_corridors.air_conditioners.first.status
          
          expect(final_ac_status).to eq(STATUS_ON)
        end
      end

      context "when power consumtion is more than max power" do
        it "should turn off the ac" do
          floor = HotelAutomation::Floor.new(1, 1)
          sub_corridors = floor.sub_corridors.first
          sub_corridors.lights.first.turn_on

          floor.check_and_reset_power
          final_ac_status = sub_corridors.air_conditioners.first.status
          
          expect(final_ac_status).to eq(STATUS_OFF)
        end
      end
    end
  end
end
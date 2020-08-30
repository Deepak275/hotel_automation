require 'spec_helper'

module HotelAutomation
  RSpec.describe Corridor do
    describe "#current_status" do

      it "should return the current status of appliances of corridor" do
        appliances = HotelAutomation::Corridor.new
        expected_output = "     Light 1: OFF\n     AC 1: OFF\n"

        expect(appliances.current_status).to eq(expected_output)
      end
    end
    
    describe "#move" do
      it "should set the move to true" do
        appliances = HotelAutomation::Corridor.new
        appliances.move

        expect(appliances.was_moving?).to be_truthy
      end
    end
    
    describe "#unmove" do
      it "should set the move to false" do
        appliances = HotelAutomation::Corridor.new
        appliances.unmove

        expect(appliances.was_moving?).to be_falsey
      end
    end
    
    describe "#was_moving?" do
        it "should show show motion status to true" do
          appliances = HotelAutomation::Corridor.new
          appliances.move
  
          expect(appliances.was_moving?).to be_truthy
        end

      context "when not moving" do
        it "should show motion status as false" do
          appliances = HotelAutomation::Corridor.new
          appliances.unmove
  
          expect(appliances.was_moving?).to be_falsey
        end
      end
    end
  end
end
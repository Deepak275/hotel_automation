require 'spec_helper'

module HotelAutomation
  RSpec.describe Corridor do
    describe "#current_status" do

      it "should return the current status of appliances of corridor" do
        appliances = HotelAutomation::Corridor.new
        p appliances.air_conditioners
        p appliances.lights
        expected_output = "  Light 1: OFF\n  Light 2: OFF\n   AC 1: OFF\n   AC 2: OFF\n"

        expect(appliances.current_status).to eq(expected_output)
      end
    end
    
    # describe "#turn_off" do

    #   it "should set the status to off" do
    #     appliances = HotelAutomation::Appliances.new(STATUS_ON, 5)
    #     appliances.turn_off

    #     expect(appliances.status).to eq(STATUS_OFF)
    #   end
    # end
    
    # describe "#status" do
    #   it "should show the status" do
    #     appliances = HotelAutomation::Appliances.new(STATUS_ON, 5)

    #     expect(appliances.status).to eq(STATUS_ON)
    #   end
    # end
    
    # describe "#power_consumption" do
    #   context "when status is on" do
    #     it "should show the power consumption" do
    #       appliances = HotelAutomation::Appliances.new(STATUS_ON, 5)
  
    #       expect(appliances.power_consumption).to eq(5)
    #     end
    #   end

    #   context "when status is off" do
    #     it "should show the power consumption as 0" do
    #       appliances = HotelAutomation::Appliances.new(STATUS_OFF, 5)
  
    #       expect(appliances.power_consumption).to eq(0)
    #     end
    #   end
    # end
  end
end
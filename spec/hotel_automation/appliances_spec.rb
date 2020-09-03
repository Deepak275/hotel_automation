require 'spec_helper'

module HotelAutomation
  RSpec.describe Appliances do
    describe "#turn_on" do

      it "should set the status to on" do
        appliances = HotelAutomation::Appliances.new(STATUS_OFF, 5)
        appliances.turn_on

        expect(appliances.status).to eq(STATUS_ON)
      end
    end
    
    describe "#turn_off" do
      it "should set the status to off" do
        appliances = HotelAutomation::Appliances.new(STATUS_ON, 5)
        appliances.turn_off

        expect(appliances.status).to eq(STATUS_OFF)
      end
    end
    
    describe "#status" do
      it "should show the status" do
        appliances = HotelAutomation::Appliances.new(STATUS_ON, 5)

        expect(appliances.status).to eq(STATUS_ON)
      end
    end
    
    describe "#power_consumption" do
      context "when status is on" do
        it "should show the power consumption" do
          appliances = HotelAutomation::Appliances.new(STATUS_ON, 5)
  
          expect(appliances.power_consumption).to eq(5)
        end
      end

      context "when status is off" do
        it "should show the power consumption as 0" do
          appliances = HotelAutomation::Appliances.new(STATUS_OFF, 5)
  
          expect(appliances.power_consumption).to eq(0)
        end
      end
    end
  end
end
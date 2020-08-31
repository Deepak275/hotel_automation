module HotelAutomation
  RSpec.describe Floor do
    describe "#current_status" do
      let(:expected_output) { "Floor 1\n  Main Corridor 1 \n     Light 1: ON\n     AC 1: ON\n  Sub Corridor 1 \n     Light 1: OFF\n     AC 1: ON\n  Max permissible for this floor: 25\n  Current Power consumption: 25\n" } 
      it "should return the current status of hotel object" do
        controller = instance_double("controller", :add_observer => 'some object')
        hotel = HotelAutomation::Hotel.new(1, 1, 1, controller)

        allow(controller).to receive(:add_observer)
        expect(hotel.current_status).to eq(expected_output)
      end
    end
  end
end    
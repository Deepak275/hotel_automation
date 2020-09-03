module HotelAutomation
  RSpec.describe Floor do
    let(:hotel) { HotelAutomation::Hotel.new(1, 1, 1) }

    describe "#current_status" do 
      let(:expected_output) { "Floor 1\n  Main Corridor 1 \n     Light 1: ON\n     AC 1: ON\n  Sub Corridor 1 \n     Light 1: OFF\n     AC 1: ON\n  Max permissible for this floor: 25\n  Current Power consumption: 25\n" } 
      it "should return the current status of hotel object" do
        expect(hotel.current_status).to eq(expected_output)
      end
    end

    describe '#update' do
      context "when floor is invalid" do
        it 'should return nil and does not change the state' do
          initial_status = hotel.current_status
          
          expect(hotel.update(2, 1, false)).to be_nil
          expect(hotel.current_status).to eq(initial_status)
        end
      end
      
      context "when corridor is invalid" do
        it 'should return nil and does not change the state' do
          initial_status = hotel.current_status
          
          expect(hotel.update(1, 2, false)).to be_nil
          expect(hotel.current_status).to eq(initial_status)
        end
      end
      
      context "when there is movement" do
        let(:expected_output) { "Floor 1\n  Main Corridor 1 \n     Light 1: ON\n     AC 1: ON\n  Sub Corridor 1 \n     Light 1: ON\n     AC 1: OFF\n  Max permissible for this floor: 25\n  Current Power consumption: 20\n" } 
        
        it 'should reset the power consumption accordingly' do
          hotel.update(1, 1, true)
          hotel.current_status
          expect(hotel.current_status).to eq(expected_output)
        end
      end

      context "when no movement" do
        let(:expected_output) { "Floor 1\n  Main Corridor 1 \n     Light 1: ON\n     AC 1: ON\n  Sub Corridor 1 \n     Light 1: OFF\n     AC 1: ON\n  Max permissible for this floor: 25\n  Current Power consumption: 25\n" } 
        
        it 'should reset the power consumption accordingly' do
          hotel.update(1, 1, false)
          hotel.current_status
          expect(hotel.current_status).to eq(expected_output)
        end
      end
    end
  end
end    
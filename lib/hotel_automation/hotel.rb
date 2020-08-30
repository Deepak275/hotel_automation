module HotelAutomation
  class Hotel
    attr_accessor :floors
  
    def initialize(num_floors, num_of_mc, num_of_sc, controller)
      @floors = []
      num_floors.times{ @floors << Floor.new(num_of_mc, num_of_sc) }
      controller.add_observer(self)
    end
  
    def current_status
      status = ''
      @floors.each_with_index do |floor, i|
        status << "Floor #{i+1}" + "\n"
        status << floor.current_status
      end
      status
    end
  
    def update(floor, sub_corridor, movement)
      if(floor < 1 || floor > @floors.size)
        puts 'There is no such floor. INVALID INPUT'
        return
      end
      current_floor = @floors[floor-1]
      sub_corridors = current_floor.sub_corridors
      if(sub_corridor < 1 || sub_corridor > sub_corridors.size)
        puts "There is no such sub corridor for floor #{floor}. INVALID INPUT"
        return
      end
      sc = sub_corridors[sub_corridor-1]
      if movement
        sc.move
        sc.lights.each {|light| light.turn_on}
      elsif !movement && sc.was_moving?
        sc.unmove
        sc.lights.each {|light| light.turn_off}
      end

      current_floor.check_and_reset_power
    end
  end
end
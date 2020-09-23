module HotelAutomation
  class Power
    attr_accessor :floors

    def initialize(floors)
      @floors = floors
    end

    def check_and_reset_hotel_consumption
      @floors.each { |floor| check_and_reset_power(floor) }
    end

    def check_and_reset_power(floor)
      @main_corridors = floor.main_corridors
      @sub_corridors = floor.sub_corridors

      return if power_limit_reached?
      @sub_corridors = floor.sub_corridors
      
      if power_consumption_per_floor < max_power
        @sub_corridors.each do |sc|
          sc.air_conditioners.each {|ac| ac.turn_on}
        end
      else
        catch (:done) do
          @sub_corridors.each do |sc|
            sc.air_conditioners.each do |ac|
              ac.turn_off
              throw :done if power_consumption_per_floor <= max_power
            end
          end
        end
      end
    end

    def power_consumption_per_floor
      power_in_units = 0
      power_in_units += @main_corridors.inject(0) {|r, mc| r + mc.power_consumption}
      power_in_units += @sub_corridors.inject(0) {|r, sc| r + sc.power_consumption}
      power_in_units
    end
    
    def floor_current_status(floor)
      @main_corridors = floor.main_corridors
      @sub_corridors = floor.sub_corridors

      status = ''
      @main_corridors.each_with_index do |mc, i|
        status << "  Main Corridor #{i+1} " + "\n"
        status << mc.current_status
      end
      @sub_corridors.each_with_index do |sc, i|
        status << "  Sub Corridor #{i+1} " + "\n"
        status << sc.current_status
      end
      status << "  Max permissible for this floor: #{max_power}\n"
      status << "  Current Power consumption: #{self.power_consumption_per_floor}\n"
      status
    end

    private

    def max_power
      @main_corridors.size * 15 + @sub_corridors.size * 10
    end

    def power_limit_reached?
      (power_consumption_per_floor == max_power) || ((power_consumption_per_floor < max_power) &&(power_consumption_per_floor + @sub_corridors.length*10) > max_power)
    end
  end
end
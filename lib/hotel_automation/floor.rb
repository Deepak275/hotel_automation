module HotelAutomation
  class Floor
    attr_accessor :main_corridors
    attr_accessor :sub_corridors

    def initialize(no_of_mc, no_of_sc)
      @main_corridors = []
      @sub_corridors = []
      no_of_mc.times do
        mc = Corridor.new
        mc.lights.each {|light| light.turn_on}
        mc.air_conditioners.each {|ac| ac.turn_on}
        @main_corridors << mc
      end
      no_of_sc.times{ @sub_corridors << Corridor.new }
      check_and_reset_power
    end

    def current_status
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
      status << "  Current Power consumption: #{self.power_consumption}\n"
      status
    end

    def check_and_reset_power
      return if power_consumption == max_power
      if power_consumption < max_power
        @sub_corridors.each do |sc|
          sc.air_conditioners.each {|ac| ac.turn_on}
        end
      else
        catch (:done) do
          @sub_corridors.each do |sc|
            sc.air_conditioners.each do |ac|
              ac.turn_off
              throw :done if power_consumption <= max_power
            end
          end
        end
      end
    end
  
    def power_consumption
      power_in_units = 0
      power_in_units += @main_corridors.inject(0) {|r, mc| r + mc.power_consumption}
      power_in_units += @sub_corridors.inject(0) {|r, sc| r + sc.power_consumption}
      power_in_units
    end
  
    private

    def max_power
      @main_corridors.size * 15 + @sub_corridors.size * 10
    end
  end
end
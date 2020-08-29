module HotelAutomation
  class Corridor
    attr_accessor :lights
    attr_accessor :air_conditioners
  
    def initialize
      @air_conditioners, @lights = [], []
      @lights << Appliances.new(STATUS_OFF, DEFAULT_UNITS_LIGHTS)
      @air_conditioners << Appliances.new(STATUS_OFF, DEFAULT_UNITS_AC)
      @movement = false
    end
  
    def current_status
      status = ''
      @lights.each_with_index do |light, i|
        status << "  Light #{i+1}: #{light.status}" + "\n"
      end
      @air_conditioners.each_with_index do |ac, i|
        status << "   AC #{i+1}: #{ac.status}" + "\n"
      end
      status
    end
  
    def move
      @movement = true
    end
  
    def unmove
      @movement = false
    end
  
    def was_moving?
      @movement
    end
  
    def power_consumption
      pc = 0
      pc += @lights.inject(0) {|r, light| r + light.power_consumption}
      pc += @air_conditioners.inject(0) {|r, ac| r + ac.power_consumption}
      pc
    end
  end
end
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
    end
  end
end
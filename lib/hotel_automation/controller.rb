require 'observer'

module HotelAutomation
  class Controller
    include Observable
  
    attr_accessor :hotel

    MOVEMENT_ACTIONS = ["MOTION", "NOMOTION"]

    def initialize
      ARGV.empty? ? hotel_cmdline_input : hotel_file_input(ARGV.first)
      add_listner
    end

    def user_actions
      ARGV.empty? ? cmdline_input_actions : file_input_actions(ARGV.first)
    end

    private

    def hotel_cmdline_input
      print "Enter the number of Floors: "
      floors = gets.chomp
      print "Enter the number of Main Corridors: "
      mc_per_floor = gets.chomp
      print "Enter the number of Sub Corridors: "
      sc_per_floor = gets.chomp

      build_hotel(floors, mc_per_floor, sc_per_floor) 
    end
    
    def hotel_file_input(input_file)
      input_content = File.read(input_file).split("\n")
      floors = input_content.first
      mc_per_floor = input_content[1]
      sc_per_floor = input_content[2]

      puts "Building hotel with floor: #{floors}, main_corridor_per_floor: #{mc_per_floor}, sub_corridor_per_floor: #{sc_per_floor}"
      build_hotel(floors, mc_per_floor, sc_per_floor)
      puts "Done!"
    end

    def build_hotel(num_floors, num_of_mc, num_of_sc)
      @hotel = Hotel.new(num_floors.to_i, num_of_mc.to_i, num_of_sc.to_i)
    end
    
    def add_listner
      self.add_observer(@hotel)
    end

    def cmdline_input_actions
      loop do
        puts 'Enter any of the commands: MOTION, STATUS, EXIT, NOMOTION'
        
        command = gets.chomp.downcase

        case command
        when 'motion', 'm'
          print 'Enter floor number: '
          floor = gets.chomp.to_i
          print 'Enter Sub Corridor number: '
          sub_corridor = gets.chomp.to_i
          changed
          notify_observers(floor, sub_corridor, true)
        when 'nomotion', 'n'
          print 'Enter floor number: '
          floor = gets.chomp.to_i
          print 'Enter Sub Corridor number: '
          sub_corridor = gets.chomp.to_i
          changed
          notify_observers(floor, sub_corridor, false)
        when 'status', 's', ''
          puts hotel.current_status
        when 'exit', 'q!', 'e'
          puts 'Thank you!!'
          break
        else
          puts "Invalid Input! Please provid valid input."
        end
      end
    end

    def file_input_actions(input_file)
      action_content = File.read(input_file).split("\n").drop(3)

      for next_input_line in action_content

        action_array = next_input_line.split(' ')
        if MOVEMENT_ACTIONS.include? (action_array.first)
          movement_input = next_input_line.split(' ')
          floor = movement_input[1].to_i
          sub_corridor = movement_input[2].to_i
          command = movement_input.first
        elsif
          command = next_input_line
        end

        puts "\nEnter any of the commands: MOTION, STATUS, EXIT, NOMOTION"
        puts "firing command: #{command}"
        
        command.downcase!

        case command
        when 'motion', 'm'
          changed
          notify_observers(floor, sub_corridor, true)
        when 'nomotion', 'n'
          changed
          notify_observers(floor, sub_corridor, false)
        when 'status', 's', ''
          puts hotel.current_status
        when 'exit', 'q!', 'e'
          puts 'Thank you!!'
          break
        else
          puts "Invalid Input! Please provid valid input."
        end
        puts "\n"
      end
    end
  end
end
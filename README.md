# HotelAutomation

To automate the regulation of power consumption in hotel to save power

## Local Setup

* Clone the repo in your working dir and cd hote_automation.
* Run `bundle install` to install the dependency gems.

## RUN in your local
* There are two ways you can run this in your local:

#### Command line input: 
1. Run chmod a+x bin/hotel_automation
2. ./bin/hotel_automation and supply the prompted inputs

#### File input: 
1. create a file in the gem directory `input.txt` with the given below format

```
1
1
1
STATUS
MOTION 1 1
STATUS
NOMOTION 1 1
STATUS
```

2. First three lines setup the hotel, indicating floors, main corridors and sub corridors.
3. Next line you can provide any  command  `MOTION, STATUS, EXIT, NOMOTION`
4. You will get output somthing like:
```
Building hotel with floor: 1, main_corridor_per_floor: 1, sub_corridor_per_floor: 1
Done!

Enter any of the commands: MOTION, STATUS, EXIT, NOMOTION
firing command: STATUS
Floor 1
  Main Corridor 1
     Light 1: ON
     AC 1: ON
  Sub Corridor 1
     Light 1: OFF
     AC 1: ON
  Max permissible for this floor: 25
  Current Power consumption: 25


Enter any of the commands: MOTION, STATUS, EXIT, NOMOTION
firing command: MOTION


Enter any of the commands: MOTION, STATUS, EXIT, NOMOTION
firing command: STATUS
Floor 1
  Main Corridor 1
     Light 1: ON
     AC 1: ON
  Sub Corridor 1
     Light 1: ON
     AC 1: OFF
  Max permissible for this floor: 25
  Current Power consumption: 20
```


## Run specs:
* Run command `rspec` in your gem directory.


## Architecture

`Controller` -->   `Hotel` --> `Floor` --> `Corridor`--> `Appliances`


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/hotel_automation. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the HotelAutomation project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/hotel_automation/blob/master/CODE_OF_CONDUCT.md).

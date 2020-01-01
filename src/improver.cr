# Functions to "improve" a given Schedule for a given Problem
# Improvements include:
#   - moving some families out of busy days, even pref lessens a step or two
#   - putting families into underflow and slow days
#   - looking for families on their 8th, 9th, 10th pref - move 'em!
#   - looking for random-ish trades to improve overall cost

require "./bloviator"
require "./demand"
require "./problem"
require "./schedule"


module TourScheduler


class Improver
    def initialize()
    end


    def improve(schedule : Schedule,  problem : Problem) : Schedule
        schedule
    end

end


end  # module

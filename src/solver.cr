
require "./demand"
require "./problem"
require "./schedule"


module TourScheduler


class Solver

    def initialize(name : String, arb_param : UInt64)
        @junk = arb_param
    end


    def solve(prob : Problem) : Schedule
        sched = Schedule.new(@name + "(" + prob.name + ")")
        return sched
    end


end  # class Solver





class SubGreedySolver
    def initialize(prefpattern :  Array(Pref))
    end

    def solve(prob : Problem) : Schedule
        sched = Schedule.new(@name + "(" + prob.name + ")")
        return sched
    end
end



end  # module

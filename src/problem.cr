
require "./demand"


module TourScheduler




struct DayPopParams
    getter mindaypop
    getter maxdaypop
    getter targetdaypop

    def initialize(@minpop : Int32, @maxpop : Int32, target : Int32)
    end
end


class Problem

    getter demands : DemandList
    getter daypops : DayPopParams

    def initialize(@demands : DemandsList, @daypops : DayPopParams)
    end
end



def self.partition(problem : Problem,  n : Int32, clumpsize : Int32) : Array(Problem)

    mins = Array(Int32).new()
    maxs = [] of Int32

    mins
    subprobs = [] of Problem
    return subprobs
end

end # module

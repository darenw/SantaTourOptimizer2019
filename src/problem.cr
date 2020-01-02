
require "./demand"


module TourScheduler




struct DayPopParams
    property mindaypop
    property maxdaypop

    def initialize(@mindaypop : Int32, @maxdaypop : Int32)
    end
end


class Problem

    getter name
    getter demands : DemandList
    getter daypops : DayPopParams

    def initialize(@name : String, @demands : DemandList, @daypops : DayPopParams)
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

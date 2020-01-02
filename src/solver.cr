
require "./demand"
require "./problem"
require "./schedule"


module TourScheduler


class Solver

    getter name

    def initialize(@name : String)
    end


    def solve(prob : Problem) : Schedule
        sched = Schedule.new(@name + "(" + prob.name + ")")
        return sched
    end


end  # class Solver



class StupidSerialSolver  <  Solver
    def initialize
        super "stupid1234"
    end

    def solve(prob : Problem)  : Schedule
        sched = Schedule.new(@name + prob.name, prob.daypops)
        day=1
        prob.demands.fams.each do |fam|
            sched.assim
            day = day+1
            if day > NDAYS
                day =1
            end
        end
    end
end

class SubGreedySolver  <  Solver

    def initialize(@prefpattern : Array(Int32))
        super "subgreedy[#{@prefpattern}]"
    end

    def solve(prob : Problem) : Schedule
        sched = Schedule.new(@name + prob.name, prob.daypops )
        ipp = 0
        idem = 0
        prob.demands.fams.each  do |fam|
            #Bloviator.step("soft assign fid=#{fam.id} ipp=#{ipp} p=#{@prefpattern[ipp]}")
            famok = sched.assign_family_soft(fam, @prefpattern[ipp].to_u8)
            if !famok
                # force family into favorite day anyway - deal with overflows later
                sched.assign_family(fam, 4)
            end
            ipp +=1
            if ipp >= @prefpattern.size
                ipp=0
            end
            idem +=1
        end

        return sched
    end
end



end  # module

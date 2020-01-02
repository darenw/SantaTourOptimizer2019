
require "./demand"
require "./bloviator"


module TourScheduler


struct Assignment
    property fam : FamilyInfo
    property day : Day
    property pref : Pref

    def initialize(@fam, @pref)
        @day = @fam.days[@pref-1]
    end
end



class Schedule

    getter name
    getter assignments
    getter daypops

    def initialize(@name : String, @daypops : DayPopParams )
        @assignments = [] of Assignment
    end


    def assign_family(fam : FamilyInfo,  p : Pref)  : Assignment
        clear_fam(fam.id)  # make sure family isn't already listed
        ass = Assignment.new(fam, p)
        @assignments << ass
        return ass
    end


    def assign_family_soft(fam : FamilyInfo,  p : Pref) : Assignment | Nil
        # assign family to day at stated pref level, but if day is full,
        # go to next less preferred day.
        # If succesful, returns the Assignment. Otherwise, Nil.
        clear_fam(fam.id)
        while (p<=NPREFS)
            if p+fam.size <= daypops.maxdaypop
                return assign_family(fam, p)
            end
            p += 1
        end
        return nil
    end


    def npeople_for_day(d : Day)
        n = 0
        @assignments.each  { |a|  n += a.fam.size  if a.day==d  }
        n
    end


    def day_counts : Array(Int32)  # indexed by day-1, where day =  1.. 100
        # For faster execution, we should keep an array .daycounts, update
        # it in parallel with every action.  TBD...
        counts = Array(Int32).new(NDAYS, 0)  # indexed by [day-1]  
        @assignments.each do |a|
            counts[a.day-1] += a.fam.size
        end
        counts
    end


    def bad_days(margin = 0)  : NamedTuple(slow: Array(Day), busy: Array(Day))
        dc = day_counts
        slowdays = [] of Day
        busydays = [] of Day
        dc.each_with_index do   |npeople, iday|
            day = iday+1   # because daycounts[0] is really "day 1"
            if npeople < daypops.mindaypop + margin
                slowdays << day.to_u8
            elsif npeople > daypops.maxdaypop - margin
                busydays << day.to_u8
            end
        end
        return {slow: slowdays, busy: busydays}
    end


    def asgns_for_day(d : Day)
        result = [] of Assignment
        @assignments.each do |a|
            if a.day == d
                result << a
            end
        end
        result
    end


    def asgn_for_fam(f : FamId) : Assignment | Nil
        # for speed, create an array indexed by famid,
        # maintain during all mutating methods.  TBD LATER...
        @assignments.find { |a| a.fam.id==f }
    end


    def clear_fam(famid : FamId)
        i = @assignments.index { |a| a.fam.id==famid }
        if i
            @assignments.delete_at(i)
        end

    end


    def write_submit_file(fname : String)
        f = File.new(fname, mode="w")
        f.printf "family_id,assigned_day\n"
        @assignments.each  do |a|
            f.printf  "%d,%d\n",  a.id, a.day
        end
        f.close
    end

    def print_highlighted_days(i1 : Int32,  i2 : Int32)
        @assignments[i1 .. i2].each  do |a|
            s = String.build do |sb|
                sb << "Fam%04d (%1d) "  % [a.fam.id, a.fam.size]
                a.fam.days.each_with_index  do |d,ipref|
                    want_bold = (a.day == d)
                    want_uline = (ipref+1 == a.pref)
                    if want_bold
                        sb << Bloviator.hot()
                    end
                    if want_uline
                        sb << Bloviator.uline()
                    end
                    sb <<  "%3d"  % d
                    if want_uline
                        sb << Bloviator.ulineoff
                    end
                    sb << Bloviator.reset()
                end
            end
            puts s
        end
    end
end




def self.merge(scheds : Array(Schedule) )

    bigsched = Schedule.new("MERGED")
    scheds.each  do |sch|
        bigsched.eat(sch)
    end
    return bigsched
end


end # module

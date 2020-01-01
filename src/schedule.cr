
require "./demand"
require "./problem"


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

    def initialize(@name : String, @prob : Problem)
        @asses = [] of Assignment
    end


    def assign_family(f : FamId,  p : Pref)
        remove_fam(f)  # removes if famid is listed, else quietly ignores
        @asses << Assignment.new(dems.faminfo(f), p)
    end


    def npeople_for_day(d : Day)
        n = 0
        @asses.each  { |ass|  n += ass.fam.size  if ass.day==d  }
        n
    end

    def day_counts : Array(Int32)  # indexed by day-1, where day =  1.. 100
        counts = Array(Int32).new(NDAYS)

    end

    def asses_for_day(d : Day)
        result = [] of Assignment
        @asses.each do |ass|
            if ass.day == d
                result << ass
            end
        end
        result
    end

    def ass_for_fam(f : FamId) : Assignment | Nil
        # for speed, create an array indexed by famid,
        # maintain during all mutating methods.  TBD LATER...
        @asses.find { |ass| ass.fam.id==f }
    end

    def remove_fam(f : FamId)
        a = @asses.find { |ass| ass.id==f }
        if a
            @asses.delete_at(a)
        end

    end


    def write_submit_file(fname : String)
        f = File.new(fname, mode="w")
        f.printf "family_id,assigned_day\n"
        @asses.each  do |ass|
            f.printf  "%d,%d\n",  ass.id, ass.day
        end
        f.close
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

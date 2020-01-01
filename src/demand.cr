

module TourScheduler

alias FamId = UInt16   # Identifies families
alias Day   = UInt8    # Identifies day of tour, 1 to 100
alias Pref  = UInt8    # Preference level for a day.  1 = fave, 10 = least

# Pref:  1=favorite to NPREFS=least.  0 = none/skip/empty
NPREFS = 10

# Day = 1 to 100.   Index arrays such as FamilyInfo.days[] with day-1 = 0 to 99
NDAYS = 100

class FamilyInfo
    getter id : FamId
    getter size : Int32        # signed; we'll want to add & subtract
    getter days : Array(Day)   # Which day they like, indexed by pref-1

    def initialize(line : String)
        parts = line.strip.split(',')
        if parts.size != 12
            raise "Bad line in input file: " + line
        end
        @size = parts[-1].to_i32
        @id = parts[0].to_u16
        @days = Array(Pref).new(NPREFS, 0)  # 0 not a valid day; watch for errors
        @days.fill { |p| (parts[p+1].to_i).to_u8 }
    end

    def stringed()
        String.build do |sb|
            sb << "Fam_%04d n=%d wants  "  %  {id, size}
            days.each { |d|  sb << " %3d"  %  d  }
        end
    end
end



class DemandList
    getter fams : Array(FamilyInfo)

    def initialize(name : String)
        @fams = Array(FamilyInfo).new
    end

    def fam(f : FamId) : FamilyInfo | Nil
        return @fams.find { |fam| fam.id == f }
    end

    def add(fam : FamilyInfo)
        @fams << fam
    end


    def created_sorted(): DemandList
    end


    def print_head_tail()
          # puts "Demands List #{@name} head & tail:"
          @fams[0 .. 4].each do |f|
               puts f.stringed
          end

          @fams[-5 .. -1].each do |f|
              puts f.stringed
          end
    end
    
end


def self.read_family_info_file(fname : String)
    dems = DemandList.new("FILE")
    lines = File.read_lines(fname)
    lines.each do  |line|
        if line[0].number?
            dems.add FamilyInfo.new(line)
        end
    end
    return dems
end

end # module

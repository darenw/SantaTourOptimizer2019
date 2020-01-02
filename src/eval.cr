
require "./demand"
require "./schedule"


module TourScheduler



# Dollar amounts of rewards for scheduling non-fave days
#   giftcard:  per family
#   buffetper:  per person
#   copter:    ride per person
struct Reward
   property giftcard
   property buffet_per_person
   property copter_per_person

   def initialize(@giftcard : Float64,
                  @buffet_per_person : Float64,
                  @copter_per_person : Float64)
   end
end

Rewards = [
   Reward.new(   0,   0,   0 ),  # preflevel = 1, fave day, indexed as [0]
   Reward.new(  50,   0,   0 ),  # preflevel = 2
   Reward.new(  50,   9,   0 ),
   Reward.new( 100,   9,   0 ),
   Reward.new( 200,   9,   0 ),
   Reward.new( 200,  18,   0 ),
   Reward.new( 300,  18,   0 ),
   Reward.new( 300,  36,   0 ),
   Reward.new( 400,  36,   0 ),  # preflevel = 9
   Reward.new( 500,  36, 199 )   # preflevel = 10,  indexed as [9]
   Reward.new( 500,  36, 398 )   # preflevel beyond, for random unlisted day

]


def self.pref_cost(asgn : Assignment)
    rew = Rewards[asgn.pref-1]
    return rew.giftcard + asgn.fam.size* (rew.buffet_per_person + copter_per_person)
end



def self.cost(sched : Schedule)

    prefcost = 0.0
    sched.assignments.each  do |asgn|
        prefcost += pref_cost(asgn)
    end


    acctcost = 0.0
    daycounts = sched.day_counts()
    daydiffs : Array(Float64).new(daycounts.size)
    daycounts.each_with_index di |n,i|
        if i+1 == NDAYS
            n_next = n
        else
            n_next = daycounts[n+1]
        end
        diff = abs(n_next - n)
        acctcost = (n-125.0)/400.0 * pow(n, 0.5 + diff/50)
    end


    return prefcost + acctcost
end



end  # module

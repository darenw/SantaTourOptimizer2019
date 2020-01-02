# Santa's Workshop Tour Scheduler
# Kaggle's 2019 Christmas theme competition
# Daren Scot Wilson

require "./bloviator"
require "./demand"
require "./problem"
require "./schedule"
require "./solver"
require "./improver"

module TourScheduler

  VERSION = "0.8.0"


  def self.show_summary(sched : Schedule)
      puts "Schedule #{sched.name} summary"
      sched.print_highlighted_days(0, 9)
      sched.print_highlighted_days(sched.assignments.size-13, sched.assignments.size-1)

      puts "Day counts: "
      puts sched.day_counts
      puts

      bb = sched.bad_days(0)
      puts "#{bb[:slow].size} slow days:"
      puts bb[:slow]
      puts "#{bb[:busy].size} busy days:"
      puts bb[:busy]
  end


  familyfilepath = "../../data/family_data.csv"
  Bloviator.progress("Reading family data file #{familyfilepath}")
  fulldemands = read_family_info_file(familyfilepath)
  if !fulldemands
      Bloviator.complain("Family data file not found!")
      exit(10)
  end

  puts "Family days demanded:"
  fulldemands.print_head_tail
  puts

  daypops = DayPopParams.new(125, 300)
  fullproblem = Problem.new("full", fulldemands, daypops)

  solver = SubGreedySolver.new( [1,1,4] )
  sched = solver.solve(fullproblem)
  show_summary(sched)

  sched2 = SubGreedySolver.new( [ 6,5,1,6,3,1 ] ).solve(fullproblem)
  show_summary(sched2)


  Bloviator.progress("Done.")
end

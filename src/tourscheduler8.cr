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

  familyfilepath = "../../data/family_data.csv"
  Bloviator.progress("Reading family data file #{familyfilepath}")
  fulldemands = read_family_info_file(familyfilepath)
  if !fulldemands
      Bloviator.complain("Family data file not found!")
      exit(10)
  end

  fulldemands.print_head_tail
  
end

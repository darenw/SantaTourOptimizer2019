# Optimator7

Combinatorial optimizer for saving Santa money on hosting workshop tours.
For making submissions to Kaggle's Santa-related competition for 2019.

See https://www.kaggle.com/c/santa-workshop-tour-2019/overview/description for details.


## Installation

Build with this command in top level directory (where you find this README file, and src/):

  shards build



## Usage

Runs on Linux only (haven't tried other platforms). Example command to produce schedules:

    optimator7 ../data/family_data.csv  

Define an env variable for location of the input file, family_data.csv

    export SANTA_DATA_DIR_2019=~/Kaggle/SantaTour2019/data/

Options:   (POSSIBLY NOT IMPLEMENTED YET)

   --fmin (int)     Minimum number of families required each day (0 = no limit)
   --pmin (int)     Minumum number of people required each day  (default 125)
   --fmax (int)     Maximum number of families allowed each day  (0 = no limit)
   --pmax (int)     Maximum number of people allowed each day   (default 300)



## Development

Could this optimizer be generalized to more than this one specific Santa scheduling problem?
Be made useful in the real world?  If so, have at it!

## Contributing

1. Fork it (<https://github.com/your-github-user/optimator7/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [darenw](https://github.com/your-github-user) - creator and maintainer

require "sequel"

class SequelPersistence
  DB = Sequel.connect("postgres://localhost/metro_csa_pop_change")

  DB.disconnect

  def initialize(logger)
    DB.logger = logger
  end

  def all_populatations
    DB[:pop_change].all
  end

  def less_than_500k
    DB[:pop_change].where(:tot_pop => 1..500000).all
  end

  def between_500k_1mil
    DB[:pop_change].where(:tot_pop => 500001..1000000).all
  end

  def between_1mil_3mil
    DB[:pop_change].where(:tot_pop => 1000001..3000000).all
  end

  def more_than_3mil
    DB[:pop_change].where(:tot_pop => 3000001..100000000).all
  end

  def select_populations(params)
    population_ranges = []

    population_ranges << less_than_500k if params.keys.include?("less_than_500k")
    population_ranges << between_500k_1mil if params.keys.include?("between_500k_1mil")
    population_ranges << between_1mil_3mil if params.keys.include?("between_1mil_3mil")
    population_ranges << more_than_3mil if params.keys.include?("more_than_3mil")

    return population_ranges.flatten
  end
end

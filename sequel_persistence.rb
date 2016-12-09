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
end

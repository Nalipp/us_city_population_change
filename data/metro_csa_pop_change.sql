CREATE TABLE pop_change (
  id serial PRIMARY KEY,
  geo_area text NOT NULL,
  state text NOT NULL,
  tot_pop int NOT NULL,
  tot_pop_change int NOT NULL,
  natural_increase int NOT NULL,
  net_int_mig int NOT NULL,
  net_domestic_mig int NOT NULL
);

\copy pop_change(geo_area, state, tot_pop, tot_pop_change, natural_increase, net_int_mig, net_domestic_mig) FROM 'metro_csa_pop_change.csv' DELIMITER ',' CSV

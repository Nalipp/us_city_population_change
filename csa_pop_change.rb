require "pry"

require "sinatra"
require "sinatra/content_for"
require "tilt/erubis"

require_relative "sequel_persistence"

configure do
  set :erb, escape_html: true
  set :port, 9090
end

configure(:development) do
  enable :sessions
  require "sinatra/reloader"
  also_reload "sequel_persistence.rb"
end

before do
  @storage = SequelPersistence.new(logger)
end

get "/" do
  redirect "/query_results"
end

get "/query_results" do
  @populations = @storage.all_populatations
  erb :query_results, layout: :layout
end

post "/query_results" do
  unless params.empty?
    @populations = @storage.select_populations(params)
  else
    @populations = @storage.all_populatations
  end
  erb :query_results, layout: :layout
end

post "/reset" do
  @populations = @storage.all_populatations
  erb :query_results, layout: :layout
end

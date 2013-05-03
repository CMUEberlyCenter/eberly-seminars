set :bundle_without, [:test, :production]
set :rails_env, 'development'
server 'seminars-d01.eberly.cmu.edu', :app, :web, :db, :primary => true

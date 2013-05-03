set :bundle_without, [:development, :test]
set :rails_env, 'production'
server 'seminars-01.eberly.cmu.edu', :app, :web, :db, :primary => true

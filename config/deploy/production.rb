# server-based syntax
# ======================
server "vikstnetica17.tk", user: "deploy", roles: %w{app db web}, primary: true

role :app, %w{deploy@vikstnetica17.tk}
role :web, %w{deploy@vikstnetica17.tk}
role :db, %w{deploy@vikstnetica17.tk}

set :rails_env, :production
set :stage, :production
set :sidekiq_options_per_process, ["--queue mailers", "--queue default"]

set :ssh_options, {
  keys: %w(/Users/vik/.ssh/deploy_id_rsa),
  forward_agent: true,
  auth_methods: %w(publickey password)
}

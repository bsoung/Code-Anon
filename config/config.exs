# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :discuss,
  ecto_repos: [Discuss.Repo]

# Configures the endpoint
config :discuss, Discuss.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "JKm3s/gmkYm8WWTK1887tS5ohD5kJ4IjEuIZBOVJvu1RwSpL787H8VQgjaITN4PP",
  render_errors: [view: Discuss.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Discuss.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# telling ueberauth, hey here's all the authentication you need to work with - just github!
# pass in a tuple, first arg is ref to github strategy that we installed, second element is a list for any options we want to pass in
config :ueberauth, Ueberauth,
	providers: [
		github: { Ueberauth.Strategy.Github, [] }
	]

# ********************MUST HIDE LATER*****************************
# ********************
config :ueberauth, Ueberauth.Strategy.Github.OAuth,
	client_id: "32c9985c5f1778a373d1",
	client_secret: "af1438f467ae87175cbc5f570a7e33753a022911"








  

import Config

config :ectopg, Ectopg.Repo,
  database: "ectopg_repo",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"

config :ectopg,
  ecto_repos: [Ectopg.Repo]

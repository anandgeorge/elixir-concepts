defmodule Ectopg.Repo do
  use Ecto.Repo,
    otp_app: :ectopg,
    adapter: Ecto.Adapters.Postgres
end

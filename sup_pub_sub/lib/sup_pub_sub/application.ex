defmodule SupPubSub.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      {Phoenix.PubSub, name: PubSub, adapter_name: Phoenix.PubSub.PG2},
      {SupPubSub.Pub, []},
      {SupPubSub.Sub, []}
      # Starts a worker by calling: SupPubSub.Worker.start_link(arg)
      # {SupPubSub.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Supervisor]
    Supervisor.start_link(children, opts)
  end
end

defmodule Ectopg.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      Ectopg.Repo
      # Starts a worker by calling: Ectopg.Worker.start_link(arg)
      # {Ectopg.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Ectopg.Supervisor]
    Supervisor.start_link(children, opts)
  end
end

defmodule Supervised.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      {Supervised.Child, [1,2,3]} # the child name and arguments
      # Starts a worker by calling: Supervised.Worker.start_link(arg)
      # {Supervised.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Supervised.Supervisor]
    Supervisor.start_link(children, opts)
  end
end

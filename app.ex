defmodule App do
  use Application

  def start(_type, _args) do
    children = [
      {GS, [:hello]}
    ]
    Supervisor.start_link(children, strategy: :one_for_one)
  end
end

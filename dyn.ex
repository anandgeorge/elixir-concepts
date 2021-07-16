defmodule Dynamic do
  use DynamicSupervisor

  def start() do
    DynamicSupervisor.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def init(_) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  def create(alphabet) do
    DynamicSupervisor.start_child(__MODULE__, {Alphabet, alphabet})
  end
end

defmodule Alphabet do
  use GenServer

  def start_link(alphabet) do
    GenServer.start_link(__MODULE__, alphabet, name: String.to_atom(alphabet))
  end

  def init(alphabet) do
    {:ok, alphabet}
  end
end

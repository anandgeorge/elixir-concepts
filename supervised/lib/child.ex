defmodule Supervised.Child do
  use GenServer

  def init(state) do
    {:ok, state}
  end

  def start_link(state \\ []) do
    IO.inspect(state)
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
    GenServer.start_link(__MODULE__, state, name: Child)
  end
end

defmodule SupPubSub.Sub do
  use GenServer

  def init(state) do
    Phoenix.PubSub.subscribe(
      PubSub, "elixir"
    )
    {:ok, state}
  end

  def start_link(state \\ []) do
    GenServer.start_link(__MODULE__, state, name: Subscriber)
  end

  def handle_info({:read, id}, state) do
    IO.inspect(id)
    {:noreply, state}
  end
end

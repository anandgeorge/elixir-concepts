defmodule SupPubSub.Pub do
  use GenServer

  def init(state) do
    publish()
    {:ok, state}
  end

  def start_link(state \\ []) do
    GenServer.start_link(__MODULE__, state, name: Publisher)
  end

  def handle_info(:timer, state) do
    publish()
    {:noreply, state}
  end

  defp publish() do
    Phoenix.PubSub.broadcast(
      PubSub, "elixir", {:read, :random.uniform(100)}
    )
    Process.send_after(self(), :timer, 5_000)
  end
end

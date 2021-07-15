defmodule A do
  def start do
    children =[
      {B, []},
      %{
        id: C,
        start: {C, :start_link, []},
        type: :supervisor
      }
    ]
    Supervisor.start_link(children, name: :a, strategy: :one_for_one)
  end
end

defmodule B do
  def child_spec(_) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, []},
      type: :worker
    }
  end

  def start_link() do
    Agent.start_link(fn -> [] end, name: :b)
  end
end

defmodule C do
  def start_link() do
    children = [
      {D, []}
    ]
    Supervisor.start_link(children, name: :c, strategy: :one_for_one)
  end
end

defmodule D do
  use GenServer

  def child_spec(_) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, []},
      type: :worker
    }
  end

  def start_link() do
    GenServer.start_link(__MODULE__, %{}, name: :d)
  end

  def put(pid, key, value) do
    GenServer.cast(pid, {:put, key, value})
  end

  def get(pid, key) do
    GenServer.call(pid, {:get, key})
  end

  def init(state) do
    {:ok, state}
  end

  def handle_cast({:put, key, value}, state) do
    {:noreply, Map.put(state, key, value)}
  end

  def handle_call({:get, key}, _, state) do
    {:reply, Map.get(state, key), state}
  end

end

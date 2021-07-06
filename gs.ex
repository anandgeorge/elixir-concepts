defmodule GS do
    use GenServer

    @impl true
    def init(stack) do
        schedule_work()
        {:ok, stack}
    end

    @impl true
    # def handle_call(:pop, _from, [head | tail]) do
      def handle_call(:pop, _from, state) do
        [head | tail] = state
        {:reply, head, tail}
    end

    @impl true
    def handle_cast({:push, element}, state) do
        {:noreply, [element | state]}
    end

    @impl true
    def handle_info(:work, state) do
        schedule_work()
        {:noreply, state}
    end

    defp schedule_work do
        # Process.send_after(self(), :work, 2 * 60 * 60 * 1000)
        Process.send_after(self(), :work, 5000)
    end

    def start_link(default) when is_list(default) do
        # GenServer.start_link(__MODULE__, default, name: App)
        GenServer.start_link(__MODULE__, default)
    end

    def push(pid, element) do
        GenServer.cast(pid, {:push, element})
    end

    def pop(pid) do
        GenServer.call(pid, :pop)
    end
end

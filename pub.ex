defmodule Pub do
    def start do
      spawn(fn -> loop([]) end)
    end

    def loop(subscribers) do
      new = receive do
        pid -> process(subscribers, pid)
      end
      loop(new)
    end
    defp process(subscribers, {:subscribe, pid}) do
      [pid | subscribers]
    end
    defp process(subscribers, {:unsubscribe, pid}) do
      List.delete(subscribers, pid)
    end
    defp process(subscribers, {:message, pub, key, value}) do
      subscribers
      |> Enum.map(fn x -> send(x, {:put, pub, key, value}) end)
      subscribers
    end
    def subscribe(pid, key) do
      send(pid, {:subscribe, key})
    end
    def unsubscribe(pid, key) do
      send(pid, {:unsubscribe, key})
    end
    def message(pub, key, value) do
      send(pub, {:message, pub, key, value})
    end
end

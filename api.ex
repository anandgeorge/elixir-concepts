defmodule API do
    def start do
        spawn(fn -> loop(%{}) end)
    end
    def loop(current) do
        new = receive do
            message -> process(current, message)
        end
        loop(new)
    end
    defp process(current, {:put, key, value}) do
        Map.put(current, key, value)
    end
    defp process(current, {:get, key, caller}) do
        send(caller, {:response, Map.get(current, key)})
        current
    end
    def put(pid, key, value) do
        send(pid, {:put, key, value})
    end
    def get(pid, key) do
        send(pid, {:get, key, self()})
        receive do
            {:response, value} -> value
        end
    end
end

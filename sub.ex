defmodule Sub do
  def start do
      spawn(fn -> loop(%{}) end)
  end

  def loop(current) do
      new = receive do
          message -> process(current, message)
      end
      loop(new)
  end
  defp process(current, {:put, pub, key, value}) do
    if key == "hello" do
      Pub.message(pub, "halo", "Universe")
    end
    Map.put(current, key, value)
  end
  defp process(current, {:get, key, caller}) do
      send(caller, {:response, Map.get(current, key)})
      current
  end
  def get(pid, key) do
      send(pid, {:get, key, self()})
      receive do
          {:response, value} -> value
      end
  end
end

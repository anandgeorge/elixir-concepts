defmodule SubTimer do
  def start do
      spawn(fn -> timer(); IO.puts("Staring up"); loop(%{}) end)
  end
  def loop(current) do
      new = receive do
          message -> IO.inspect(message); process(current, message)
      end
      loop(new)
  end
  defp process(current, {:put, pub, key, value}) do
    if key == "hello" do
      Pub.message(pub, "halo", "Universe")
    end
    Map.put(current, key, value)
  end
  defp process(current, :info) do
    timer()
    if Map.has_key?(current, "halo") do
      Map.put(current, "not", "easy")
    else
      current
    end
  end
  defp process(current, {:get, key, caller}) do
      send(caller, {:response, Map.get(current, key)})
      current
  end
  defp timer() do
    Process.send_after(self(), :info, 5_000)
  end
  def get(pid, key) do
      send(pid, {:get, key, self()})
      receive do
          {:response, value} -> value
      end
  end
end

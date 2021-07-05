# Concepts

A set of examples to explain concepts in Elixir. We cover processes, agents and pub sub in this set. There are better implementations of the concepts. However the idea is to get under the hood of these concepts to understand their basic working principles.

## Usage

Clone this repository.

```elixir
	cd elixir-concepts
	iex
```

```elixir
    iex(1)> c("api.ex")
    [API]
    iex(2)> pid = API.start()
    #PID<0.116.0>
    iex(3)> API.put(pid, "hello", "world")
    {:put, "hello", "world"}
    iex(4)> API.get(pid, "hello")
    "world"
    iex(5)> c("agentapi.ex")
    [AgentAPI]
    iex(6)> {:ok, pid} = AgentAPI.start()
    {:ok, #PID<0.127.0>}
    iex(7)> AgentAPI.put(pid, "hello", "world")
    :ok
    iex(8)> AgentAPI.get(pid, "hello")
    "world"
    iex(9)> c("pub.ex")
    [Pub]
    iex(10)> c("sub.ex")
    [Sub]
    iex(11)> pub = Pub.start()
    #PID<0.145.0>
    iex(12)> sub = Sub.start()
    #PID<0.147.0>
    iex(13)> Pub.subscribe(pub, sub)
    {:subscribe, #PID<0.147.0>}
    iex(14)> Pub.message(pub, "hello", "world")
    {:message, #PID<0.145.0>, "hello", "world"}
    iex(15)> Sub.get(sub, "hello")             
    "world"
    iex(16)> Sub.get(sub, "halo")
```


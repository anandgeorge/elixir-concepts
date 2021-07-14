# Concepts

A set of examples to explain concepts in Elixir. We cover processes, agents and pub sub in this set. There are better implementations of the concepts. However the idea is to get under the hood of these concepts to understand their basic working principles.

## Usage

Clone this repository.

```elixir
cd elixir-concepts
iex
```
#### State machine implementation basics

```elixir
    iex(1)> c("api.ex")
    [API]
    iex(2)> pid = API.start()
    #PID<0.116.0>
    iex(3)> API.put(pid, "hello", "world")
    {:put, "hello", "world"}
    iex(4)> API.get(pid, "hello")
    "world"
```

#### State machine using Agents

```elixir
    iex(5)> c("agentapi.ex")
    [AgentAPI]
    iex(6)> {:ok, pid} = AgentAPI.start()
    {:ok, #PID<0.127.0>}
    iex(7)> AgentAPI.put(pid, "hello", "world")
    :ok
    iex(8)> AgentAPI.get(pid, "hello")
    "world"
```

#### State machine with PubSub

```elixir
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
    "Universe" 
```

#### State machine with PubSub and Timed functions

```elixir
    iex(1)> c("pub.ex")
    [Pub]
    iex(2)> c("sub_timer.ex")
    [SubTimer]
    iex(3)> pub = Pub.start()
    #PID<0.123.0>
    iex(4)> sub = SubTimer.start()
    Staring up
    #PID<0.125.0>                         
    iex(5)> Pub.subscribe(pub, sub)
    {:subscribe, #PID<0.125.0>}                              
    iex(6)> Pub.message(pub, "hi", "how")
    {:put, #PID<0.123.0>, "hi", "how"}
    {:message, #PID<0.123.0>, "hi", "how"}                         
    iex(7)> SubTimer.get(sub, "hello")
    {:get, "hello", #PID<0.107.0>}
    nil                            
    iex(8)> SubTimer.get(sub, "not")
    {:get, "not", #PID<0.107.0>}
    nil                            
    iex(9)> SubTimer.get(sub, "hi")  
    {:get, "hi", #PID<0.107.0>}
    "how"                                      
    iex(10)> Pub.message(pub, "hello", "world")
    {:put, #PID<0.123.0>, "hello", "world"} 
    # Message published to PubSub
    {:message, #PID<0.123.0>, "hello", "world"} 
    # Message delivered to SubTimer via subscription
    {:put, #PID<0.123.0>, "halo", "Universe"} 
    # Message published to PubSub via if condition in SubTimer                                   
    iex(11)> SubTimer.get(sub, "hello") 
    {:get, "hello", #PID<0.107.0>}
    "world"                               
    iex(12)> SubTimer.get(sub, "halo")
    {:get, "halo", #PID<0.107.0>}
    "Universe"                               
    iex(13)> SubTimer.get(sub, "not") 
    # State updated by timer after the if condition satisfied
    {:get, "not", #PID<0.107.0>}
    "easy"
```

#### State machine using a GenServer and a public interface

```elixir
    iex(1)> c("gs.ex")
    [GS]
    iex(2)> GS.start_link([:hello])
    {:ok, #PID<0.116.0>}
    iex(3)> GS.pop(App) 
    :hello
    iex(4)> GS.push(App, :world)
    :ok
    iex(5)> GS.pop(App)         
    :world
```

#### Supervised State machine using a GenServer and a public interface

```elixir
    iex(1)> c("gs.ex")
    [GS]
    iex(2)> c("app.ex")  
    [App]
    iex(3)> App.start(nil, nil) 
    {:ok, #PID<0.123.0>}
    iex(4)> GS.pop(App)
    :hello
    iex(5)> GS.push(App, :world) 
    :ok
    iex(6)> GS.pop(App)         
    :world
    iex(7)> 
```

#### Creating an umbrella app i.e. an app with two or more applications

```elixir
    mix new umbrella --umbrella
    cd umbrella
    cd apps
    mix new one
    mix new two
    cd one
```

Link the two applications by adding two as a dependency in one in mix.exs of app one
    {:two, in_umbrella: true}

Run mix.deps to update dependency

Go to the root of the application one and run the app. Note how we call a function from app two in one.

```elixir
    iex -S mix
    iex(1)> Two.hello
    "Hello from Two"
```
#### Creating a supervised app i.e. an app with a supervision tree

```elixir
    mix new supervised --sup
    cd supervised
    iex -S mix
    [1, 2, 3]
    iex(1)> :observer.start()
```

Notice the Observer shows two processes Elixir.Supervised.Child and Elixir.Child created with a link to Elixir.Supervised.Supervisor. This name is taken from the options (opts) given to start the Supervisor.

#### Defining a struct

See struct.ex. Notice keys that are required listed under @enforce_keys.
The struct will be referred to as %State{} where State is the name of the module with the function defintion.

#### Overloading functions and functions with guard clauses

Overloading allows you to define different implementations of the same function based on the number of arguments. You can also define guard clauses for a set of functions with same number of arguments but different conditions. See overload.ex.

```elixir
    iex(1)> c("overload.ex")
    [Overload]
    iex(2)> Overload.hello(:say, 1)
    Sorry, you cannot have a number 1 for a name
    :ok
    iex(3)> Overload.hello(:say, "Al") 
    Hello Al
    :ok
    iex(4)> Overload.hello(:say)      
    "Hello World"
```

#### Subscription tree with Phoenix PubSub

Creating a subscription tree with Phoenix PubSub and two processes, one for Publishing and another for Subscribing. Add {:phoenix_pubsub, "~> 2.0"} to the dependencies. See folder sup_pub_sub for implementation details.

```elixir
    cd sup_pub_sub
    iex -S mix
    iex(1)> 73
    95
    51
    32
    60
    92
    , 67
    48
    60
```
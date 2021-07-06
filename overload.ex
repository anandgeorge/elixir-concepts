defmodule Overload do
  def hello(:say) do
    "Hello World"
  end

  def hello(:say, name) when is_number(name) do
    IO.puts("Sorry, you cannot have a number #{name} for a name" )
  end

  def hello(:say, name) do
    IO.puts("Hello #{name}")
  end


end

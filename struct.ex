defmodule Struct do
  @enforce_keys [:username, :password]
  defstruct [
    :username,
    :firstname,
    :lastname,
    :dob,
    :address,
    :password
  ]
end

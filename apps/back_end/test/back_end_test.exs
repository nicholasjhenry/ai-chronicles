defmodule BackEndTest do
  use ExUnit.Case
  doctest BackEnd

  test "greets the world" do
    assert BackEnd.hello() == :world
  end
end

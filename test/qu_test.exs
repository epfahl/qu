defmodule QuTest do
  use ExUnit.Case
  doctest Qu

  test "greets the world" do
    assert Qu.hello() == :world
  end
end

defmodule IdenticonsTest do
  use ExUnit.Case
  doctest Identicons

  test "greets the world" do
    assert Identicons.hash_input("hello world") ==
             %Identicons.Image{
               hex: [94, 182, 59, 187, 224, 30, 238, 208, 147, 203, 34, 187, 143, 90, 205, 195]
             }
  end
end

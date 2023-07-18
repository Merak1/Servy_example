defmodule Servy.Recurse do
  import Servy.Helpers
  def loopy([head | tail] ) do
    IO.puts "Head: #{head}  |  Tail: #{inspect(tail)}"
    loopy(tail)
  end


  def loopy([]), do: IO.puts("Done!")


  def sum([head|tail], total) do

   total = total + head
    # head+tail
    # Map.put(total, key, value)

    sum(tail, total)
  end

  def sum([], total), do: green(total)

  def triple([head|tail]) do

    IO.inspect(tail)
    [head * 3 | triple(tail)]

    # triple(tail, total_list)
  end

  def triple([]), do: []

# ______________________________________________________________________
  def triple2([]), do: []


   def triple2(list) do
    triple2(list, [])
  end

  defp triple2([head|tail], current_list) do
    triple2(tail, [head*3 | current_list])
  end

  defp triple2([], current_list) do
    current_list |> Enum.reverse()
  end

end



# Servy.Recurse.triple([1,2,3,4,5])
IO.inspect Servy.Recurse.triple2([1,2,3,4,5])
# Servy.Recurse.sum([1,2,3,4,5,5], 0)

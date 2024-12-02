defmodule Day01 do
  @moduledoc """
    https://adventofcode.com/2024/day/1
  """
  def calc_list_distances(list01, list02) when is_list(list01) and is_list(list02) do
    list01 = list01 |> Enum.sort()
    list02 = list02 |> Enum.sort()

    [list01, list02] |> List.zip() |> Enum.map(fn {a, b} -> abs(b - a) end) |> Enum.sum()
  end

  def read_line_numbers(line) when is_binary(line) do
    line
    |> String.trim()
    |> String.split(~r"\s+")
    |> Enum.map(&String.to_integer/1)
    |> List.to_tuple()
  end

  def read_input_file(filename) do
    File.stream!(filename)
    |> Enum.map(&read_line_numbers/1)
    |> Enum.reduce([[], []], fn {first, second}, [list01, list02] ->
      [[first | list01], [second | list02]]
    end)
    |> Enum.map(&Enum.reverse/1)
    |> List.to_tuple()
  end

  def calc_list_similarities(list01, list02) when is_list(list01) and is_list(list02) do
    freqs = list02 |> Enum.frequencies()

    similarity_list = fn item ->
      Map.get(freqs, item, 0) * item
    end

    list01
    |> Enum.map(similarity_list)
    |> Enum.sum()
  end
end

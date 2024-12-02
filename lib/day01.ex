defmodule Day01 do
  def calcListDistances(list01, list02) when is_list(list01) and is_list(list02) do
    list01 = list01 |> Enum.sort()
    list02 = list02 |> Enum.sort()

    [list01, list02] |> List.zip() |> Enum.map(fn {a, b} -> abs(b - a) end) |> Enum.sum()
  end

  def readLineNumbers(line) when is_binary(line) do
    line
    |> String.trim()
    |> String.split(~r"\s+")
    |> Enum.map(&String.to_integer/1)
    |> List.to_tuple()
  end

  def readInputFile(filename) do
    File.stream!(filename)
    |> Enum.map(&readLineNumbers/1)
    |> Enum.reduce([[], []], fn {first, second}, [list01, list02] ->
      [[first | list01], [second | list02]]
    end)
    |> Enum.map(&Enum.reverse/1)
    |> List.to_tuple()
  end

  def calcListSimilarities(list01, list02) when is_list(list01) and is_list(list02) do
    freqs = list02 |> Enum.frequencies()

    calcSimilarity = fn item ->
      Map.get(freqs, item, 0) * item
    end

    list01
    |> Enum.map(calcSimilarity)
    |> Enum.sum()
  end
end

defmodule Day02Test do
  use ExUnit.Case
  doctest Day02

  test "reads line levels into a list" do
    assert Day02.readLineLevels("7 6 4 2 1") == [7, 6, 4, 2, 1]
  end

  test "can determine if a line is safe or not" do
    test_cases = [
      {[7, 6, 4, 2, 1], true},
      {[1, 2, 7, 8, 9], false},
      {[9, 7, 6, 2, 1], false},
      {[1, 3, 2, 4, 5], false},
      {[8, 6, 4, 4, 1], false},
      {[1, 3, 6, 7, 9], true}
    ]

    test_cases
    |> Enum.each(fn {line, expected} ->
      assert Day02.isLineSafe(line) == expected,
             "#{line |> numListToString()} should be #{if expected, do: "safe", else: "unsafe"}"
    end)
  end

  test "reads example file and outputs safe reports" do
    assert Day02.calcSafeReports("./inputs/day02_example.txt") == 2
  end

  test "reads input file and outputs safe reports" do
    assert Day02.calcSafeReports("./inputs/day02.txt") == 359
  end

  def numListToString(numList) do
    "[" <> (numList |> Enum.map(&Integer.to_string/1) |> Enum.join(", ")) <> "]"
  end
end

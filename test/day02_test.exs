defmodule Day02Test do
  use ExUnit.Case
  doctest Day02

  test "reads line levels into a list" do
    assert Day02.read_line_levels("7 6 4 2 1") == [7, 6, 4, 2, 1]
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
      assert Day02.is_line_safe(line) == expected,
             "#{line |> num_list_to_string()} should be #{if expected, do: "safe", else: "unsafe"}"
    end)
  end

  test "reads example file and outputs safe reports" do
    assert Day02.calc_safe_reports("./inputs/day02_example.txt") == 2
  end

  test "reads input file and outputs safe reports" do
    assert Day02.calc_safe_reports("./inputs/day02.txt") == 359
  end

  test "calcs possible lists out of a line" do
    line = [7, 6, 4, 2, 1]

    expected_result = [
      [6, 4, 2, 1],
      [7, 4, 2, 1],
      [7, 6, 2, 1],
      [7, 6, 4, 1],
      [7, 6, 4, 2]
    ]

    assert Day02.line_possibilities_without_step(line) == expected_result
  end

  test "reads example file and outputs safe reports with dampener" do
    assert Day02.calc_safe_reports_with_dampener("./inputs/day02_example.txt") == 4
  end

  test "reads input file and outputs safe reports with dampener" do
    assert Day02.calc_safe_reports_with_dampener("./inputs/day02.txt") == 418
  end

  def num_list_to_string(num_list) when is_list(num_list) do
    "[" <> (num_list |> Enum.map_join(", ", &Integer.to_string/1)) <> "]"
  end
end

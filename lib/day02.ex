defmodule Day02 do
  @moduledoc """
    https://adventofcode.com/2024/day/2
  """
  def read_file_levels(filename) do
    File.stream!(filename)
    |> Enum.map(&read_line_levels/1)
  end

  def read_line_levels(line) when is_binary(line) do
    line |> String.trim() |> String.split(~r"\s+") |> Enum.map(&String.to_integer/1)
  end

  def is_line_safe(line) when is_list(line) do
    step_differences =
      line
      |> Enum.chunk_every(2, 1, :discard)
      |> Enum.map(fn [first, second] -> second - first end)

    steps_increasing = step_differences |> Enum.map(fn diff -> diff > 0 end)

    # either all must be increasing or all must be decreasing
    safe_direction =
      steps_increasing |> Enum.all?() || !(steps_increasing |> Enum.any?())

    # the increase/decrease must be between 1 and 3
    safe_distance =
      step_differences
      |> Enum.all?(fn step_difference ->
        abs(step_difference) > 0 and abs(step_difference) <= 3
      end)

    safe_distance && safe_direction
  end

  @doc """
  With the "Problem Dampener", a line is safe if
  - it is safe by is_line_safe() rules
  - it would be safe if, by removing any one level, is_line_safe would consider it safe.
  """
  def is_line_safe_with_dampener(line) when is_list(line) do
    if is_line_safe(line) do
      true
    else
      Enum.any?(line |> line_possibilities_without_step() |> Enum.map(&is_line_safe/1))
    end
  end

  def line_possibilities_without_step(line) when is_list(line) do
    for i <- 0..(length(line) - 1), into: [] do
      List.delete_at(line, i)
    end
  end

  defp calc_reports(filename, line_fun) when is_function(line_fun) do
    filename |> read_file_levels() |> Enum.map(line_fun) |> Enum.count(fn is_safe -> is_safe end)
  end

  def calc_safe_reports(filename) do
    filename |> calc_reports(&is_line_safe/1)
  end

  def calc_safe_reports_with_dampener(filename) do
    filename |> calc_reports(&is_line_safe_with_dampener/1)
  end
end

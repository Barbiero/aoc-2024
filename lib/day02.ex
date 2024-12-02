defmodule Day02 do
  def readFileLevels(filename) do
    File.stream!(filename)
    |> Enum.map(&readLineLevels/1)
  end

  def readLineLevels(line) when is_binary(line) do
    line |> String.trim() |> String.split(~r"\s+") |> Enum.map(&String.to_integer/1)
  end

  def isLineSafe(line) when is_list(line) do
    stepDiffs =
      line
      |> Enum.chunk_every(2, 1, :discard)
      |> Enum.map(fn [first, second] -> second - first end)

    stepsIncreasing = stepDiffs |> Enum.map(fn diff -> diff > 0 end)

    # either all must be increasing or all must be decreasing
    safe_direction =
      stepsIncreasing |> Enum.all?() || !(stepsIncreasing |> Enum.any?())

    # the increase/decrease must be between 1 and 3
    safe_distance =
      stepDiffs
      |> Enum.all?(fn stepDiff -> abs(stepDiff) > 0 and abs(stepDiff) <= 3 end)

    safe_distance && safe_direction
  end

  @doc """
  With the "Problem Dampener", a line is safe if
  - it is safe by isLineSafe() rules
  - it would be safe if, by removing any one level, isLineSafe would consider it safe.
  """
  def isLineSafeWithDampener(line) when is_list(line) do
    if isLineSafe(line) do
      true
    else
      Enum.any?(line |> linePossibilitiesWithoutStep() |> Enum.map(&isLineSafe/1))
    end
  end

  def linePossibilitiesWithoutStep(line) when is_list(line) do
    for i <- 0..(length(line) - 1), into: [] do
      List.delete_at(line, i)
    end
  end

  def calcReports(filename, lineFun) when is_function(lineFun) do
    filename |> readFileLevels() |> Enum.map(lineFun) |> Enum.count(fn isSafe -> isSafe end)
  end

  def calcSafeReports(filename) do
    filename |> calcReports(&isLineSafe/1)
  end

  def calcSafeReportsWithDampener(filename) do
    filename |> calcReports(&isLineSafeWithDampener/1)
  end
end

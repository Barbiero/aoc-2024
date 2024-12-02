defmodule Day01Test do
  use ExUnit.Case
  doctest Day01

  test "compares lists and returns the sum of the distances" do
    list01 = [3, 4, 2, 1, 3, 3]
    list02 = [4, 3, 5, 3, 9, 3]

    assert Day01.calcListDistances(list01, list02) == 11
  end

  test "reads a line correctly" do
    assert Day01.readLineNumbers("123 346\n") == {123, 346}
  end

  test "reads example file correctly" do
    {list01, list02} = Day01.readInputFile("./inputs/day01_example.txt")

    assert list01 == [3, 4, 2, 1, 3, 3]
    assert list02 == [4, 3, 5, 3, 9, 3]
  end

  test "calculate result part 1" do
    {list01, list02} = Day01.readInputFile("./inputs/day01.txt")

    assert Day01.calcListDistances(list01, list02) == 2_000_468
  end

  test "compares lists and returns the sum of similarties" do
    list01 = [3, 4, 2, 1, 3, 3]
    list02 = [4, 3, 5, 3, 9, 3]

    assert Day01.calcListSimilarities(list01, list02) == 31
  end

  test "calculate result part 2" do
    {list01, list02} = Day01.readInputFile("./inputs/day01.txt")

    assert Day01.calcListSimilarities(list01, list02) == 18_567_089
  end
end

defmodule Day03Test do
  use ExUnit.Case
  doctest Day03

  test "gets mul instructions from example line" do
    instrs =
      Day03.get_mul_instructions(
        "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))"
      )

    assert instrs == [
             %Day03.Operation{op: :mul, left: 2, right: 4},
             %Day03.Operation{op: :mul, left: 5, right: 5},
             %Day03.Operation{op: :mul, left: 11, right: 8},
             %Day03.Operation{op: :mul, left: 8, right: 5}
           ]
  end

  test "calculates all mul instructions" do
    instrs = [
      %Day03.Operation{op: :mul, left: 2, right: 4},
      %Day03.Operation{op: :mul, left: 5, right: 5},
      %Day03.Operation{op: :mul, left: 11, right: 8},
      %Day03.Operation{op: :mul, left: 8, right: 5}
    ]

    assert instrs |> Day03.calculate_mul_instructions() == [8, 25, 88, 40]
  end

  test "reads example file and returns correct result" do
    assert Day03.read_file_calc_instructions_sum("./inputs/day03_example.txt") == 161
  end

  test "reads file and returns correct result" do
    assert Day03.read_file_calc_instructions_sum("./inputs/day03.txt") == 166_630_675
  end

  test "gets mul instructions from example line with do-dont switches" do
    instrs =
      Day03.get_mul_instructions_with_switches(
        "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))"
      )

    assert instrs == [
             %Day03.Operation{op: :mul, left: 2, right: 4},
             %Day03.Operation{op: :mul, left: 8, right: 5}
           ]
  end

  test "reads example file and returns correct result with do-dont switches" do
    assert Day03.read_file_calc_instructions_sum_with_switches("./inputs/day03_example2.txt") ==
             48
  end

  test "reads file and returns correct result with do-dont switches" do
    assert Day03.read_file_calc_instructions_sum_with_switches("./inputs/day03.txt") ==
             93_465_710
  end
end

defmodule Day03 do
  @moduledoc """
  https://adventofcode.com/2024/day/3
  """

  @mul_regex ~r"mul\(\d{1,3},\d{1,3}\)"

  @mul_regex_parts ~r"mul\((\d{1,3}),(\d{1,3})\)"

  @spec calculate_mul_instructions(list(Day03.Operation)) :: list(integer())
  def calculate_mul_instructions(instructions) when is_list(instructions) do
    instructions |> Enum.map(&Day03.Operation.exec/1)
  end

  def get_mul_instructions(line) when is_binary(line) do
    @mul_regex
    |> Regex.scan(line)
    |> List.flatten()
    |> Enum.map(&mul_string_to_obj/1)
  end

  def read_file_calc_instructions_sum(filename) when is_binary(filename) do
    File.read!(filename)
    |> String.trim()
    |> get_mul_instructions()
    |> calculate_mul_instructions()
    |> Enum.sum()
  end

  defp mul_string_to_obj(mul_str) when is_binary(mul_str) do
    [left, right] =
      @mul_regex_parts
      |> Regex.run(mul_str, capture: :all_but_first)
      |> Enum.map(&String.to_integer/1)

    %Day03.Operation{
      op: :mul,
      left: left,
      right: right
    }
  end

  @do_regex ~r"do\(\)"
  @dont_regex ~r"don't\(\)"

  @spec get_mul_instructions_with_switches(binary()) :: list(Day03.Operation)
  def get_mul_instructions_with_switches(line) when is_binary(line) do
    instructions =
      Regex.compile!(
        "(?<do>#{@do_regex |> Regex.source()})|(?<dont>#{@dont_regex |> Regex.source()})|(?<mul>#{@mul_regex |> Regex.source()})"
      )
      |> Regex.scan(line, capture: :all_names)
      |> List.flatten()
      |> Enum.filter(fn str -> String.length(str) > 0 end)

    %{should_take: _, acc: instructions} =
      Enum.reduce(instructions, %{should_take: true, acc: []}, &take_only_if_enabled/2)

    instructions
    |> Enum.reverse()
    |> Enum.map(&mul_string_to_obj/1)
  end

  defp take_only_if_enabled(curr, %{should_take: should_take, acc: acc}) do
    cond do
      Regex.match?(@do_regex, curr) ->
        %{should_take: true, acc: acc}

      Regex.match?(@dont_regex, curr) ->
        %{should_take: false, acc: acc}

      true ->
        %{
          should_take: should_take,
          acc:
            case should_take do
              true -> [curr | acc]
              false -> acc
            end
        }
    end
  end

  def read_file_calc_instructions_sum_with_switches(filename) when is_binary(filename) do
    File.read!(filename)
    |> String.trim()
    |> get_mul_instructions_with_switches()
    |> calculate_mul_instructions()
    |> Enum.sum()
  end
end

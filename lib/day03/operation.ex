defmodule Day03.Operation do
  @moduledoc """
  represents an operation for Day03
  """

  @enforce_keys [:op, :left, :right]
  defstruct op: :mul, left: 0, right: 0

  def exec(%Day03.Operation{op: :mul, left: l, right: r}) do
    l * r
  end
end

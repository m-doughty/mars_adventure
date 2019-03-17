defmodule MarsAdventure.Domain.Location do
  alias __MODULE__

  @type t :: %Location{x: integer(), y: integer()}
  @enforce_keys [:x, :y]
  defstruct @enforce_keys

  @max_y_value 50
  @max_x_value 50

  @spec new(integer(), integer()) :: {:ok, Location.t()} | {:error, String.t()}
  def new(x, y) when is_integer(x) and is_integer(y) and y <= @max_y_value and x <= @max_x_value and y >= 0 and x >= 0 do
    {:ok, %Location{x: x, y: y}}
  end

  def new(_, _) do
    {:error, "Invalid construction parameters."}
  end

  @spec offset(Location.t(), integer(), integer()) :: Location.t() | {:error, String.t()}
  def offset(%Location{x: x, y: y}, delta_x, delta_y) when is_integer(delta_x) and is_integer(delta_y) do
    %Location{x: x + delta_x, y: y + delta_y}
  end

  def offset(_, _, _) do
    {:error, "Invalid offset"}
  end
end

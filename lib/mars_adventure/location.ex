defmodule MarsAdventure.Location do
  @type t :: %__MODULE__{x: integer(), y: integer()}
  @enforce_keys [:x, :y]
  defstruct @enforce_keys

  @spec new(integer(), integer()) :: {:ok, __MODULE__.t()} | {:error, String.t()}
  def new(x, y) when is_integer(x) and is_integer(y) do
    {:ok, %__MODULE__{x: x, y: x}}
  end

  def new(_, _) do
    {:error, "Invalid construction parameters."}
  end
end

defmodule MarsAdventure.World do
  alias MarsAdventure.Location

  @type t :: %__MODULE__{top_right_corner: Location.t()}
  @enforce_keys [:top_right_corner]
  defstruct @enforce_keys

  @spec new(Location.t()) :: {:ok, __MODULE__.t()} | {:error, String.t()}
  def new(%Location{} = location) do
    {:ok, %__MODULE__{top_right_corner: location}}
  end

  def new(_) do
    {:error, "Invalid construction parameters."}
  end
end

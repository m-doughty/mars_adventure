defmodule MarsAdventure.World do
  alias __MODULE__
  alias MarsAdventure.Location

  @type t :: %World{top_right_corner: Location.t(), scented_locations: list()}
  @enforce_keys [:top_right_corner, :scented_locations]
  defstruct @enforce_keys

  @spec new(Location.t()) :: {:ok, __MODULE__.t()} | {:error, String.t()}
  def new(%Location{} = location) do
    {:ok, %__MODULE__{top_right_corner: location, scented_locations: []}}
  end

  def new(_) do
    {:error, "Invalid construction parameters."}
  end
end

defmodule MarsAdventure.Robot do
  alias MarsAdventure.Location

  @type t :: %__MODULE__{location: Location.t(), orientation: String.t()}
  @enforce_keys [:location, :orientation]
  defstruct @enforce_keys

  @valid_orientations ["N", "E", "S", "W"]

  @spec new(Location.t(), String.t()) :: {:ok, __MODULE__.t()} | {:error, String.t()}
  def new(%Location{} = location, orientation) when orientation in @valid_orientations do
    {:ok, %__MODULE__{location: location, orientation: orientation}}
  end

  def new(location, orientation) do
    {:error, "Invalid construction parameters."}
  end

  def turn_left(%__MODULE__{orientation: orientation} = robot) do
    new_orientation = case orientation do
      "N" -> "W"
      "E" -> "N"
      "S" -> "E"
      "W" -> "S"
    end

    %__MODULE__{robot | orientation: new_orientation}
  end
end

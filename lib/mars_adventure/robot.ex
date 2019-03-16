defmodule MarsAdventure.Robot do
  alias __MODULE__
  alias MarsAdventure.Location

  @type t :: %Robot{location: Location.t(), orientation: String.t()}
  @enforce_keys [:location, :orientation]
  defstruct @enforce_keys

  @valid_orientations ["N", "E", "S", "W"]

  @spec new(Location.t(), String.t()) :: {:ok, Robot.t()} | {:error, String.t()}
  def new(%Location{} = location, orientation) when orientation in @valid_orientations do
    {:ok, %Robot{location: location, orientation: orientation}}
  end

  def new(_, _) do
    {:error, "Invalid construction parameters."}
  end
end

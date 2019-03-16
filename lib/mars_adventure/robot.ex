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

  @spec turn_left(Robot.t()) :: Robot.t()
  def turn_left(%Robot{orientation: orientation} = robot) do
    new_orientation = case orientation do
      "N" -> "W"
      "E" -> "N"
      "S" -> "E"
      "W" -> "S"
    end

    %Robot{robot | orientation: new_orientation}
  end

  @spec turn_right(Robot.t()) :: Robot.t()
  def turn_right(%Robot{orientation: orientation} = robot) do
    new_orientation = case orientation do
      "N" -> "E"
      "E" -> "S"
      "S" -> "W"
      "W" -> "N"
    end

    %Robot{robot | orientation: new_orientation}
  end

  @spec move_forward(Robot.t()) :: Robot.t()
  def move_forward(%Robot{location: location, orientation: orientation} = robot) do
    {delta_x, delta_y} = case orientation do
      "N" -> {0, 1}
      "E" -> {1, 0}
      "S" -> {0, -1}
      "W" -> {-1, 0}
    end

    %Robot{robot | location: Location.offset(location, delta_x, delta_y)}
  end
end

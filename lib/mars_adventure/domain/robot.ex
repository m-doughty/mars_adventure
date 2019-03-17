defmodule MarsAdventure.Domain.Robot do
  alias __MODULE__
  alias MarsAdventure.Domain.Location
  alias MarsAdventure.Domain.World

  @type t :: %Robot{location: Location.t(), orientation: String.t(), lost: boolean()}
  @enforce_keys [:location, :orientation, :lost]
  defstruct @enforce_keys

  @valid_orientations ["N", "E", "S", "W"]

  @spec new(Location.t(), String.t()) :: {:ok, Robot.t()} | {:error, String.t()}
  def new(%Location{} = location, orientation) when orientation in @valid_orientations do
    {:ok, %Robot{location: location, orientation: orientation, lost: false}}
  end

  def new(_, _) do
    {:error, "Invalid construction parameters."}
  end

  @spec turn_left(Robot.t()) :: Robot.t()
  def turn_left(%Robot{orientation: orientation, lost: false} = robot) do
    new_orientation = case orientation do
      "N" -> "W"
      "E" -> "N"
      "S" -> "E"
      "W" -> "S"
    end

    %Robot{robot | orientation: new_orientation}
  end

  # Ignore commands if the robot is lost
  def turn_left(robot) do
    robot
  end

  @spec turn_right(Robot.t()) :: Robot.t()
  def turn_right(%Robot{orientation: orientation, lost: false} = robot) do
    new_orientation = case orientation do
      "N" -> "E"
      "E" -> "S"
      "S" -> "W"
      "W" -> "N"
    end

    %Robot{robot | orientation: new_orientation}
  end

  # Ignore commands if the robot is lost
  def turn_right(robot) do
    robot
  end

  # Accepts arguments as a tuple to allow pipe operations
  @spec move_forward({Robot.t(), World.t()}) :: {Robot.t(), World.t()}
  def move_forward({%Robot{location: location, orientation: orientation, lost: false} = robot, world}) do
    {delta_x, delta_y} = case orientation do
      "N" -> {0, 1}
      "E" -> {1, 0}
      "S" -> {0, -1}
      "W" -> {-1, 0}
    end

    new_location = Location.offset(location, delta_x, delta_y)

    case {World.out_of_bounds?(world, new_location), World.in_scented_locations?(world, location)} do
      {true, true} -> {robot, world}
      {true, false} -> {%Robot{robot | lost: true}, World.add_scent_to_location(world, location)}
      _ -> {%Robot{robot | location: new_location}, world}
    end
  end

  # Ignore commands if the robot is lost
  def move_forward({robot, world}) do
    {robot, world}
  end
end

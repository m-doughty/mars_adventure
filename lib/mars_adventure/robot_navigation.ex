defmodule MarsAdventure.RobotNavigation do
  alias MarsAdventure.Location
  alias MarsAdventure.Robot
  alias MarsAdventure.World

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

    case out_of_bounds?(world, new_location) do
      true -> {%Robot{robot | location: location, lost: true}, add_scent_to_location(world, location)}
      false -> {%Robot{robot | location: new_location}, world}
    end
  end

  # Ignore commands if the robot is lost
  def move_forward({robot, world}) do
    {robot, world}
  end

  @spec out_of_bounds?(World.t(), Location.t()) :: boolean()
  defp out_of_bounds?(%World{top_right_corner: %Location{x: max_x, y: max_y}}, %Location{x: x, y: y}) do
    cond do
      x < 0 -> true
      x > max_x -> true
      y < 0 -> true
      y > max_y -> true
      true -> false
    end
  end

  @spec add_scent_to_location(World.t(), Location.t()) :: World.t()
  defp add_scent_to_location(%World{scented_locations: scented_locations} = world, location) do
    %World{world | scented_locations: scented_locations ++ [location]}
  end
end

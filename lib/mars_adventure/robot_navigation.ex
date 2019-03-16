defmodule MarsAdventure.RobotNavigation do
  alias MarsAdventure.Location
  alias MarsAdventure.Robot

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

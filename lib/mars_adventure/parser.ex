defmodule MarsAdventure.Parser do
  alias MarsAdventure.Domain.Location
  alias MarsAdventure.Domain.Robot
  alias MarsAdventure.Domain.World

  @spec parse_specification(String.t()) :: {:ok, World.t(), [{Robot.t(), [String.t()]}]}
  def parse_specification(specification) do
    with {:ok, world, rest} <- parse_world(specification),
         {:ok, robots_with_paths} <- parse_robots_with_paths(rest) do
      {:ok, world, robots_with_paths}
    end
  end

  @spec parse_world(String.t()) :: {:ok, World.t(), String.t()} | {:error, String.t()}
  defp parse_world(specification) do
    with [world_line, rest] <- String.split(specification, "\n", parts: 2),
         [x, y] <- String.split(world_line, " ", trim: true),
         {:ok, top_right} <- Location.new(String.to_integer(x), String.to_integer(y)),
         {:ok, world} <- World.new(top_right) do
      {:ok, world, rest}
    else
      _ -> {:error, "Could not parse world."}
    end
  end

  @spec parse_robots_with_paths(String.t()) :: {:ok, [{Robot.t(), [String.t()]}]}
  defp parse_robots_with_paths(robots_and_paths) do
    robot_and_path_lines = String.split(robots_and_paths, "\n", trim: true)

    %{robots_with_paths: robots_with_paths} = Enum.reduce(robot_and_path_lines, %{line_type: :robot_line, robots_with_paths: [], current: {}}, fn (line, state) ->
      case state.line_type do
        :robot_line ->
          %{state | line_type: :path_line, current: {parse_robot(line)}}
        :path_line ->
          {robot} = state.current
          
          %{line_type: :robot_line, current: {}, robots_with_paths: state.robots_with_paths ++ [{robot, parse_path(line)}]}
      end
    end)

    {:ok, robots_with_paths}
  end

  defp parse_robot(robot_line) do
    [x, y, orientation] = String.split(robot_line, " ", trim: true)
    {:ok, location} = Location.new(String.to_integer(x), String.to_integer(y))
    {:ok, robot} = Robot.new(location, orientation)

    robot
  end

  defp parse_path(path_line) do
    String.split(path_line, "", trim: true)
  end
end

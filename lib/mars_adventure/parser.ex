defmodule MarsAdventure.Parser do
  alias MarsAdventure.Domain.Location
  alias MarsAdventure.Domain.Robot
  alias MarsAdventure.Domain.World

  @spec parse_specification(String.t()) :: {:ok, World.t(), [{Robot.t(), [String.t()]}]}
  def parse_specification(specification) do
    with {:ok, world, rest} <- parse_world(specification),
         {:ok, robots_with_commands} <- parse_robots_with_commands(rest) do
      {:ok, world, robots_with_commands}
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

  @spec parse_robots_with_commands(String.t()) :: {:ok, [{Robot.t(), [String.t()]}]}
  defp parse_robots_with_commands(robots_and_commands) do
    robots_and_commands_lines = String.split(robots_and_commands, "\n", trim: true)

    %{all: all} = Enum.reduce(robots_and_commands_lines, %{line_type: :robot_line, all: [], current: {}}, fn (line, state) ->
      case state.line_type do
        :robot_line ->
          [x, y, orientation] = String.split(line, " ", trim: true)
          {:ok, location} = Location.new(String.to_integer(x), String.to_integer(y))
          {:ok, robot} = Robot.new(location, orientation)

          %{line_type: :command_line, current: {robot}, all: state.all}
        :command_line ->
          {robot} = state.current
          commands = String.split(line, "", trim: true)

          %{line_type: :robot_line, current: {}, all: state.all ++ [{robot, commands}]}
      end
    end)

    {:ok, all}
  end
end

defmodule MarsAdventure.HandleMultipleRobots do
  @moduledoc """
  Takes a world, a list of robots, and a list of commands, executes them in turn, and returns the robot in its final state
  """
  alias MarsAdventure.Domain.Robot
  alias MarsAdventure.Domain.World

  @spec handle(World.t(), [{Robot.t(), [String.t()]}]) :: %{world: World.t(), robots: [Robot.t()]}
  def handle(world, robots_with_paths) do
    Enum.reduce(robots_with_paths, %{world: world, robots: []}, fn ({robot, commands}, state) ->
      {robot_end_state, world_end_state} = handle_robot(state.world, robot, commands)

      %{world: world_end_state, robots: state.robots ++ [robot_end_state]}
    end)
  end

  @spec handle_robot(World.t(), Robot.t(), [String.t()]) :: {Robot.t(), World.t()}
  defp handle_robot(world, robot, commands) do
    Enum.reduce(commands, {robot, world}, fn(command, state) ->
      handle_robot_command(command, state)
    end)
  end

  @spec handle_robot_command(String.t(), {Robot.t(), World.t()}) :: {Robot.t(), World.t()}
  defp handle_robot_command(command, {robot, world}) do
    case command do
      "L" -> {Robot.turn_left(robot), world}
      "R" -> {Robot.turn_right(robot), world}
      "F" -> Robot.move_forward({robot, world})
      _ -> {robot, world} # Do nothing if it's an unrecognized command.
    end
  end
end

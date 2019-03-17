defmodule MarsAdventure.ParserTest do
  use ExUnit.Case

  alias MarsAdventure.Parser

  describe "successfully parses input" do
    test "from string" do
      input = """
              5 3

              1 1 E
              RFRFRFRF

              3 2 N
              FRRFLLFFRRFLL

              0 3 W
              LLFFFLFLFL
              """

      {:ok, world, robots_and_commands} = Parser.parse_specification(input)

      assert world.top_right_corner.x == 5
      assert world.top_right_corner.y == 3

      assert length(robots_and_commands) == 3

      [
        {first_robot, first_robot_commands}, 
        {second_robot, second_robot_commands}, 
        {third_robot, third_robot_commands}
      ] = robots_and_commands

      assert first_robot.location.x == 1
      assert first_robot.location.y == 1
      assert first_robot.orientation == "E"

      assert second_robot.location.x == 3
      assert second_robot.location.y == 2
      assert second_robot.orientation == "N"

      assert third_robot.location.x == 0
      assert third_robot.location.y == 3
      assert third_robot.orientation == "W"

      assert length(first_robot_commands) == 8
      assert length(second_robot_commands) == 13
      assert length(third_robot_commands) == 10

      assert first_robot_commands == ["R", "F", "R", "F", "R", "F", "R", "F"]
    end
  end
end

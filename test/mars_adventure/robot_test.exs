defmodule MarsAdventure.RobotTest do
  use ExUnit.Case

  alias MarsAdventure.Location
  alias MarsAdventure.Robot

  describe "navigating the robot" do
    test "the robot can turn left" do
      {:ok, location} = Location.new(0, 0)
      {:ok, robot} = Robot.new(location, "E")

      robot_after_one_turn = Robot.turn_left(robot)
      robot_after_two_turns = Robot.turn_left(robot_after_one_turn)
      robot_after_three_turns = Robot.turn_left(robot_after_two_turns)
      robot_after_four_turns = Robot.turn_left(robot_after_three_turns)

      assert robot_after_one_turn.orientation == "N"
      assert robot_after_two_turns.orientation == "W"
      assert robot_after_three_turns.orientation == "S"
      assert robot_after_four_turns.orientation == "E"
    end

    test "the robot can turn right" do

    end

    test "the robot can move forward" do

    end
  end
end

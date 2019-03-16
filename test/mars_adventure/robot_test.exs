defmodule MarsAdventure.RobotTest do
  use ExUnit.Case

  alias MarsAdventure.Location
  alias MarsAdventure.Robot

  describe "the robot can turn" do
    test "left" do
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

    test "right" do
      {:ok, location} = Location.new(0, 0)
      {:ok, robot} = Robot.new(location, "E")

      robot_after_one_turn = Robot.turn_right(robot)
      robot_after_two_turns = Robot.turn_right(robot_after_one_turn)
      robot_after_three_turns = Robot.turn_right(robot_after_two_turns)
      robot_after_four_turns = Robot.turn_right(robot_after_three_turns)

      assert robot_after_one_turn.orientation == "S"
      assert robot_after_two_turns.orientation == "W"
      assert robot_after_three_turns.orientation == "N"
      assert robot_after_four_turns.orientation == "E"
    end
  end

  describe "the robot can move forward" do
    test "when facing north" do
      {:ok, location} = Location.new(5, 5)
      {:ok, robot} = Robot.new(location, "N")

      %Robot{location: location_after_one_move} = robot |> Robot.move_forward()
      %Robot{location: location_after_two_moves} = robot |> Robot.move_forward() |> Robot.move_forward()

      assert location_after_one_move.y == 6
      assert location_after_two_moves.y == 7
    end

    test "when facing east" do
      {:ok, location} = Location.new(5, 5)
      {:ok, robot} = Robot.new(location, "E")

      %Robot{location: location_after_one_move} = robot |> Robot.move_forward()
      %Robot{location: location_after_two_moves} = robot |> Robot.move_forward() |> Robot.move_forward()

      assert location_after_one_move.x == 6
      assert location_after_two_moves.x == 7
    end

    test "when facing south" do
      {:ok, location} = Location.new(5, 5)
      {:ok, robot} = Robot.new(location, "S")

      %Robot{location: location_after_one_move} = robot |> Robot.move_forward()
      %Robot{location: location_after_two_moves} = robot |> Robot.move_forward() |> Robot.move_forward()

      assert location_after_one_move.y == 4
      assert location_after_two_moves.y == 3
    end

    test "when facing west" do
      {:ok, location} = Location.new(5, 5)
      {:ok, robot} = Robot.new(location, "W")

      %Robot{location: location_after_one_move} = robot |> Robot.move_forward()
      %Robot{location: location_after_two_moves} = robot |> Robot.move_forward() |> Robot.move_forward()

      assert location_after_one_move.x == 4
      assert location_after_two_moves.x == 3
    end
  end
end

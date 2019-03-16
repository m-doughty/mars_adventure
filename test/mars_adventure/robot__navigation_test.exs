defmodule MarsAdventure.RobotNavigationTest do
  use ExUnit.Case

  alias MarsAdventure.Location
  alias MarsAdventure.Robot
  alias MarsAdventure.RobotNavigation
  alias MarsAdventure.World

  describe "the robot can turn" do
    test "left" do
      {:ok, location} = Location.new(0, 0)
      {:ok, robot} = Robot.new(location, "E")

      robot_after_one_turn = RobotNavigation.turn_left(robot)
      robot_after_two_turns = RobotNavigation.turn_left(robot_after_one_turn)
      robot_after_three_turns = RobotNavigation.turn_left(robot_after_two_turns)
      robot_after_four_turns = RobotNavigation.turn_left(robot_after_three_turns)

      assert robot_after_one_turn.orientation == "N"
      assert robot_after_two_turns.orientation == "W"
      assert robot_after_three_turns.orientation == "S"
      assert robot_after_four_turns.orientation == "E"
    end

    test "right" do
      {:ok, location} = Location.new(0, 0)
      {:ok, robot} = Robot.new(location, "E")

      robot_after_one_turn = RobotNavigation.turn_right(robot)
      robot_after_two_turns = RobotNavigation.turn_right(robot_after_one_turn)
      robot_after_three_turns = RobotNavigation.turn_right(robot_after_two_turns)
      robot_after_four_turns = RobotNavigation.turn_right(robot_after_three_turns)

      assert robot_after_one_turn.orientation == "S"
      assert robot_after_two_turns.orientation == "W"
      assert robot_after_three_turns.orientation == "N"
      assert robot_after_four_turns.orientation == "E"
    end
  end

  describe "the robot can move forward" do
    test "when facing north" do
      {:ok, location} = Location.new(5, 5)
      {:ok, world_top_right} = Location.new(7, 7)
      {:ok, robot} = Robot.new(location, "N")
      {:ok, world} = World.new(world_top_right)

      {%Robot{location: location_after_one_move}, _world} = {robot, world} |> RobotNavigation.move_forward()
      {%Robot{location: location_after_two_moves}, _world} = {robot, world} |> RobotNavigation.move_forward() |> RobotNavigation.move_forward()

      assert location_after_one_move.y == 6
      assert location_after_two_moves.y == 7
    end

    test "when facing east" do
      {:ok, location} = Location.new(5, 5)
      {:ok, world_top_right} = Location.new(7, 7)
      {:ok, robot} = Robot.new(location, "E")
      {:ok, world} = World.new(world_top_right)

      {%Robot{location: location_after_one_move}, _world} = {robot, world} |> RobotNavigation.move_forward()
      {%Robot{location: location_after_two_moves}, _world} = {robot, world} |> RobotNavigation.move_forward() |> RobotNavigation.move_forward()

      assert location_after_one_move.x == 6
      assert location_after_two_moves.x == 7
    end

    test "when facing south" do
      {:ok, location} = Location.new(5, 5)
      {:ok, world_top_right} = Location.new(7, 7)
      {:ok, robot} = Robot.new(location, "S")
      {:ok, world} = World.new(world_top_right)

      {%Robot{location: location_after_one_move}, _world} = {robot, world} |> RobotNavigation.move_forward()
      {%Robot{location: location_after_two_moves}, _world} = {robot, world} |> RobotNavigation.move_forward() |> RobotNavigation.move_forward()

      assert location_after_one_move.y == 4
      assert location_after_two_moves.y == 3
    end

    test "when facing west" do
      {:ok, location} = Location.new(5, 5)
      {:ok, world_top_right} = Location.new(7, 7)
      {:ok, robot} = Robot.new(location, "W")
      {:ok, world} = World.new(world_top_right)

      {%Robot{location: location_after_one_move}, _world} = {robot, world} |> RobotNavigation.move_forward()
      {%Robot{location: location_after_two_moves}, _world} = {robot, world} |> RobotNavigation.move_forward() |> RobotNavigation.move_forward()

      assert location_after_one_move.x == 4
      assert location_after_two_moves.x == 3
    end
  end

  describe "the robot correctly handles the world's edge" do
    test "by refusing to move over the edge" do
      {:ok, location} = Location.new(5, 5)
      {:ok, robot} = Robot.new(location, "N")
      {:ok, world} = World.new(location)

      {lost_robot, _world} = RobotNavigation.move_forward({robot, world})

      assert lost_robot.location == location
    end

    test "by marking itself as lost" do
      {:ok, location} = Location.new(5, 5)
      {:ok, robot} = Robot.new(location, "N")
      {:ok, world} = World.new(location)

      {lost_robot, _world} = RobotNavigation.move_forward({robot, world})

      assert robot.lost == false
      assert lost_robot.lost == true
    end

    test "by marking the spot on the world where it got lost" do
      {:ok, location} = Location.new(5, 5)
      {:ok, robot} = Robot.new(location, "N")
      {:ok, world} = World.new(location)

      {_robot, new_world} = RobotNavigation.move_forward({robot, world})

      assert location in new_world.scented_locations
    end

    test "by ignoring commands after it gets lost" do
      {:ok, location} = Location.new(5, 5)
      {:ok, robot} = Robot.new(location, "N")
      {:ok, world} = World.new(location)

      lost_robot_sent_turn_left = %Robot{robot | lost: true} |> RobotNavigation.turn_left()
      lost_robot_sent_turn_right = %Robot{robot | lost: true} |> RobotNavigation.turn_right()

      assert robot.orientation == lost_robot_sent_turn_left.orientation
      assert robot.orientation == lost_robot_sent_turn_right.orientation
    end
  end
end

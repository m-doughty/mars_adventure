defmodule MarsAdventure.HandleMultipleRobotsTest do
  use ExUnit.Case

  alias MarsAdventure.Domain.Location
  alias MarsAdventure.Domain.Robot
  alias MarsAdventure.Domain.World
  alias MarsAdventure.HandleMultipleRobots

  describe "pathing correctly handles" do
    test "multiple robots" do
      {:ok, world_top_right} = Location.new(6, 6)
      {:ok, world} = World.new(world_top_right)

      {:ok, first_robot_location} = Location.new(3, 3)
      {:ok, first_robot} = Robot.new(first_robot_location, "N")
      first_robot_commands = [
        "L", # 3 3 W
        "F", # 2 3 W
        "R", # 2 3 N
        "F" # 2 4 N
      ]

      {:ok, second_robot_location} = Location.new(1, 1)
      {:ok, second_robot} = Robot.new(second_robot_location, "S")
      second_robot_commands = [
        "F", # 1 1 S LOST
        "L" # 1 1 S LOST, should not rotate
      ]

      {:ok, third_robot_location} = Location.new(3, 1)
      {:ok, third_robot} = Robot.new(third_robot_location, "W")
      third_robot_commands = [
        "F", # 2 1 W
        "F", # 1 1 W
        "F", # 1 1 W, saved by the scent of second's loss
        "R", # 1 1 N
        "F" # 1 2 N
      ]

      end_state = HandleMultipleRobots.handle(world, [
        {first_robot, first_robot_commands},
        {second_robot, second_robot_commands},
        {third_robot, third_robot_commands}
      ])

      %{world: world_end_state, robots: [first_robot_state, second_robot_state, third_robot_state]} = end_state

      %World{scented_locations: scented_locations} = world_end_state
      assert length(scented_locations) == 1
      assert hd(scented_locations) == second_robot_location

      %Robot{location: %Location{x: first_x, y: first_y}, orientation: first_orientation, lost: first_lost} = first_robot_state
      %Robot{location: %Location{x: second_x, y: second_y}, orientation: second_orientation, lost: second_lost} = second_robot_state
      %Robot{location: %Location{x: third_x, y: third_y}, orientation: third_orientation, lost: third_lost} = third_robot_state

      assert first_x == 2
      assert first_y == 4
      assert first_lost == false
      assert first_orientation == "N"

      assert second_x == 1
      assert second_y == 1
      assert second_lost == true
      assert second_orientation == "S"

      assert third_x == 1
      assert third_y == 2
      assert third_lost == false
      assert third_orientation == "N"
    end
  end
end

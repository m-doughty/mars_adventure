defmodule MarsAdventure.Domain.World do
  alias __MODULE__
  alias MarsAdventure.Domain.Location

  @type t :: %World{top_right_corner: Location.t(), scented_locations: list()}
  @enforce_keys [:top_right_corner, :scented_locations]
  defstruct @enforce_keys

  @spec new(Location.t()) :: {:ok, __MODULE__.t()} | {:error, String.t()}
  def new(%Location{} = location) do
    {:ok, %__MODULE__{top_right_corner: location, scented_locations: []}}
  end

  def new(_) do
    {:error, "Invalid construction parameters."}
  end

  @spec out_of_bounds?(World.t(), Location.t()) :: boolean()
  def out_of_bounds?(%World{top_right_corner: %Location{x: max_x, y: max_y}}, %Location{x: x, y: y}) do
    cond do
      x <= 0 -> true
      x > max_x -> true
      y <= 0 -> true
      y > max_y -> true
      true -> false
    end
  end

  @spec add_scent_to_location(World.t(), Location.t()) :: World.t()
  def add_scent_to_location(%World{scented_locations: scented_locations} = world, location) do
    %World{world | scented_locations: scented_locations ++ [location]}
  end

  @spec in_scented_locations?(World.t(), Location.t()) :: boolean()
  def in_scented_locations?(%World{scented_locations: scented_locations}, location) do
    location in scented_locations
  end
end

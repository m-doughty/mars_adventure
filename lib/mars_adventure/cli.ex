defmodule MarsAdventure.CLI do
  alias MarsAdventure.HandleMultipleRobots
  alias MarsAdventure.Parser

  @spec main([binary()]) :: :ok
  def main(args \\ []) do
    {:ok, world, robots_with_paths} = args |> get_filename() |> parse_input_file() |> Parser.parse_specification
    
    HandleMultipleRobots.handle(world, robots_with_paths) |> render() 
  end

  defp get_filename(args) do
    {options, _, _} = OptionParser.parse(args, strict: [filename: :string])

    [filename: filename] = options
    
    filename
  end

  defp render(result) do
    %{robots: robots} = result

    Enum.each(robots, fn (robot) ->
      case robot.lost do
        true -> IO.puts("#{robot.location.x} #{robot.location.y} #{robot.orientation} LOST")
        false -> IO.puts("#{robot.location.x} #{robot.location.y} #{robot.orientation}")
      end
    end)
  end

  @spec parse_input_file(String.t()) :: String.t() | {:error, String.t()}
  defp parse_input_file(file_path) do
    with {:ok, specification} <- File.read(file_path) do
      IO.inspect(specification)
      specification
    end
  end
end
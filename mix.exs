defmodule MarsAdventure.MixProject do
  use Mix.Project

  def project do
    [
      app: :mars_adventure,
      version: "0.1.0",
      elixir: "~> 1.8",
      escript: escript(),
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:dialyxir, "~> 0.5", only: [:dev], runtime: false}
    ]
  end

  defp escript do
    [main_module: MarsAdventure.CLI]
  end
end

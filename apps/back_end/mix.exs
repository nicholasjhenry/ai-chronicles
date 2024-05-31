defmodule BackEnd.MixProject do
  use Mix.Project

  def project do
    [
      app: :back_end,
      version: "0.1.0",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.16",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {BackEnd.Application, []}
    ]
  end

  defp deps do
    [
      {:broadway, "~> 1.0"},
      {:httpoison, "~> 2.0"},
      {:jason, "~> 1.4"},
      {:mimic, "~> 1.7", only: :test}
    ]
  end
end

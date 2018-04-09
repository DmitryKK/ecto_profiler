defmodule EctoProfiler.Mixfile do
  use Mix.Project

  @project_url "https://github.com/DmitryKK/ecto_profiler"

  def project do
    [
      app: :ecto_profiler,
      version: "0.1.4",
      elixir: "~> 1.5",
      elixirc_paths: elixirc_paths(Mix.env),
      compilers: [:phoenix] ++ Mix.compilers,
      source_url: @project_url,
      homepage_url: @project_url,
      package: package(),
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      description: "Project for Ecto DB profiling",
      docs: [main: "readme", extras: ["README.md"]],
      deps: deps()
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_), do: ["lib", "web"]

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {EctoProfiler, []},
      applications: [:phoenix, :logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:phoenix, "~> 1.2"},
      {:phoenix_html, "~> 2.6"},
      {:dialyxir, "~> 0.5", only: [:dev], runtime: false},
      {:ex_doc, "~> 0.16", only: [:dev], runtime: false}
    ]
  end

  defp package do
    [
      maintainers: ["Dmitry Krakosevich"],
      licenses: ["MIT"],
      links: %{"GitHub" => @project_url},
      files: ~w(mix.exs README* lib web)
    ]
  end
end

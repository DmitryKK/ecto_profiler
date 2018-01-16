# EctoProfiler

[![Hex Version][hex-img]][hex]

[hex-img]: https://img.shields.io/hexpm/v/ecto_profiler.svg
[hex]: https://hex.pm/packages/ecto_profiler

Project for Ecto DB profiling

## Installation

  1. Add `ecto_profiler` to your list of dependencies in `mix.exs`:

  ```elixir
  def deps do
    [{:ecto_profiler, github: "DmitryKK/ecto_profiler", only: [:dev]}]
  end
  ```

  Fetch and compile the dependency

  `mix do deps.get, deps.compile`

  2. Ensure `ecto_profiler` is started before your application:

  ```elixir
  def application(:dev) do
    [applications: [:ecto_profiler]]
  end
  ```

  3. Add some ecto_profiler configuration to the config file `config/dev.exs`

  ```elixir
  config :ecto_profiler, EctoProfiler,
    # name of yours app
    app_name: :my_great_app,
    # title of profiling page (optional)
    page_title: "Profiling for my great APP"
  ```

  4. Add EctoProfiler logger for ecto to the config file `config/dev.exs`, for example:

  ```elixir
  config :my_greap_app, MyGreatApp.Repo,
    adapter: Ecto.Adapters.Postgres,
    username: "postgres",
    password: "postgres",
    database: "my_great_app_dev",
    hostname: "localhost",
    pool_size: 10,
    timeout: 15_000,
    pool_timeout: 15_000,
    ownership_timeout: 15_000,
    loggers: [{EctoProfiler, :log, []}]
  ```

  5. Maximize stacktrace depth for phoenix in your configuration file. Default value for dev is 20, for prod is 8. But it is litle depth and you should increase this, for example:

  ```elixir
  config, :phoenix, :stacktrace_depth, 50
  ```

  5. Add the profiling route to the router file `web/router.ex`:

  ```elixir
  defmodule MyGreatApp.Router do

    get "/profiling", EctoProfiler.MainController, :show
  ```

Start the application with iex -S mix phoenix.server

Visit http://localhost:4000/profiling

You should see page with current profiling.

## Documentation

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/ecto_profiler](https://hexdocs.pm/ecto_profiler).


## Contributing

1. Fork it
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create new Pull Request

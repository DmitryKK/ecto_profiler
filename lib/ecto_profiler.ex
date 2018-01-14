defmodule EctoProfiler do
  @moduledoc """
  Documentation for EctoProfiler.
  """

  use Application

  alias EctoProfiler.{TraceHandler, ModuleHandler, Mnesia, Interface}

  @main_app_name Application.get_env(:ecto_profiler, __MODULE__)[:app_name]

  defdelegate get_data(params), to: Interface

  def start(_type, _args) do
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_) do
    Supervisor.init([
      {Mnesia, []}
    ], strategy: :one_for_one)
  end

  def log(entry) do
    with {:current_stacktrace, trace_list} <- Process.info(self(), :current_stacktrace),
         {:ok, modules_list} <- :application.get_key(@main_app_name, :modules)
    do
      Enum.each([ModuleHandler, TraceHandler], &(&1.handle(trace_list, modules_list, entry)))
    end
  end
end

defmodule EctoProfiler.Mnesia do
  @moduledoc """
  Bag for all Mnesia tables in the project
  """
  use GenServer

  def start_link(_opts \\ []) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_) do
    :mnesia.create_table(FunctionProfiler, [attributes: [:module_with_function_and_arity, :query_time, :calls]])
    :mnesia.create_table(TraceProfiler, [attributes: [:trace, :module_with_function_and_arity, :query_time, :calls]])
    {:ok, []}
  end
end

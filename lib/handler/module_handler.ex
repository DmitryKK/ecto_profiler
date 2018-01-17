defmodule EctoProfiler.ModuleHandler do
  @moduledoc """
  It records the call of each module of the application.
  """

  use EctoProfiler.Helper

  @doc """
  Handler for data. Checks all modules and selects only those which you have defined in your application.
  It writes data to mnesia `FunctionProfiler` table.
  """

  @spec handle([tuple()], [module()], Ecto.LogEntry.t) :: :ok
  def handle(trace_list, modules_list, entry) do
    Enum.each(trace_list, fn({module, func, arity, _}) ->
      if Enum.member?(modules_list, module) do
        write_profiling_data({module, func, arity}, entry.query_time)
      end
    end)
  end

  defp write_profiling_data({module, func, arity}, extra_query_time) do
    with {:atomic, [{FunctionProfiler, _, query_time, calls}]}
      <- :mnesia.transaction(fn -> :mnesia.read(FunctionProfiler, {module, func, arity}) end)
    do
      :mnesia.transaction(fn ->
        :mnesia.write({FunctionProfiler, {module, func, arity}, time(extra_query_time) + query_time, calls + 1})
      end)
    else
      {:atomic, []} -> :mnesia.transaction(fn ->
        :mnesia.write({FunctionProfiler, {module, func, arity}, time(extra_query_time), 1})
      end)
    end
  end
end

defmodule EctoProfiler.TraceHandler do
  @moduledoc """
  It records all calls with the same trace in one record in the mnesia.
  The calling module is the one where the first call happened.
  """

  use EctoProfiler.Helper

  @doc """
  Handler for data. Checks all modules and selects only first module of yours app in trace list.
  It writes data to mnesia `TraceProfiler` table.
  """

  @spec handle([tuple()], [module()], Ecto.LogEntry.t) :: {:atomic, nonempty_list(tuple())} | nil
  def handle(trace_list, modules_list, entry) do
    Enum.reverse(trace_list)
    |> Enum.find(fn({module, _, _, _}) -> Enum.member?(modules_list, module) end)
    |> write_profiling_data(entry.query_time, trace_list)
  end

  defp write_profiling_data(nil, _, _), do: nil

  defp write_profiling_data({module, func, arity, _}, extra_query_time, trace) do
    with {:atomic, [{TraceProfiler, _, _, query_time, calls}]}
      <- :mnesia.transaction(fn -> :mnesia.read(TraceProfiler, trace) end)
    do
      :mnesia.transaction(fn ->
        :mnesia.write({TraceProfiler, trace, {module, func, arity}, time(extra_query_time) + query_time, calls + 1})
      end)
    else
      {:atomic, []} -> :mnesia.transaction(fn ->
        :mnesia.write({TraceProfiler, trace, {module, func, arity}, time(extra_query_time), 1})
      end)
    end
  end
end

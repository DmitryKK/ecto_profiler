defmodule EctoProfiler.ModuleHandler do
  @moduledoc """
  Documentation for EctoProfiler.
  """
  use EctoProfiler.Helper

  @root_module EctoProfiler

  def handle(trace_list, modules_list, entry) do
    Enum.each(trace_list, fn({module, func, arity, _}) -> 
      if Enum.member?(modules_list -- [@root_module], module) do
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

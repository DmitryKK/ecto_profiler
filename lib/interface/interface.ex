defmodule EctoProfiler.Interface do
  @moduledoc false

  def get_data(order_by: :time, for: :module) do
    with {:atomic, list} <- :mnesia.transaction(fn -> :mnesia.match_object({FunctionProfiler, :_, :_, :_}) end) do
      Enum.sort(list, fn({_, _, time_1, _}, {_, _, time_2, _}) -> time_1 >= time_2 end)
    end
  end

  def get_data(order_by: :calls, for: :module) do
    with {:atomic, list} <- :mnesia.transaction(fn -> :mnesia.match_object({FunctionProfiler, :_, :_, :_}) end) do
      Enum.sort(list, fn({_, _, _, calls_1}, {_, _, _, calls_2}) -> calls_1 >= calls_2 end)
    end
  end

  def get_data(order_by: :time, for: :trace) do
    with {:atomic, list} <- :mnesia.transaction(fn -> :mnesia.match_object({TraceProfiler, :_, :_, :_, :_}) end) do
      Enum.sort(list, fn({_, _, _, time_1, _}, {_, _, _, time_2, _}) -> time_1 >= time_2 end)
    end
  end

  def get_data(order_by: :calls, for: :trace) do
    with {:atomic, list} <- :mnesia.transaction(fn -> :mnesia.match_object({TraceProfiler, :_, :_, :_, :_}) end) do
      Enum.sort(list, fn({_, _, _, _, calls_1}, {_, _, _, _, calls_2}) -> calls_1 >= calls_2 end)
    end
  end
end

defmodule EctoProfiler.Helper do
  @moduledoc false

  defmacro __using__(_opts) do
    quote location: :keep do
      defp time(nil), do: 0

      defp time(time) do
        us = System.convert_time_unit(time, :native, :micro_seconds)
        div(us, 100) / 10
      end
    end
  end
end

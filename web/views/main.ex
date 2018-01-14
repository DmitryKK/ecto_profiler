defmodule EctoProfiler.MainView do
  use EctoProfiler.Web, :view

  def full_module_name(module, func, arity) do
    "#{inspect module}.#{func}/#{arity}"
  end

  def pretty_trace(trace) do
    Enum.map(trace, &(inspect &1)) |> Enum.join("<br>")
  end
end

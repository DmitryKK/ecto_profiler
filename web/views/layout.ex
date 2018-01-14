defmodule EctoProfiler.LayoutView do
  use EctoProfiler.Web, :view

  @module Application.get_env(:ecto_profiler, :module)

  def site_title do
    case @module && @module |> Module.split do
      [_, title | _] -> title
      [title] -> title
      _ -> "Ecto Profiler"
    end
  end
end

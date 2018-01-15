defmodule EctoProfiler.LayoutView do
  use EctoProfiler.Web, :view

  @page_title Application.get_env(:ecto_profiler, :page_title)

  def site_title do
    case @page_title && @page_title |> Module.split do
      [_, title | _] -> title
      [title] -> title
      _ -> "Ecto Profiler"
    end
  end
end

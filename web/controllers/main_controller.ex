defmodule EctoProfiler.MainController do
  @moduledoc false
  use EctoProfiler.Web, :controller

  def show(conn, %{"order" => "time", "for" => "trace"}) do
    render conn, "trace.html", data: EctoProfiler.get_data(order_by: :time, for: :trace)
  end

  def show(conn, %{"order" => "calls", "for" => "trace"}) do
    render conn, "trace.html", data: EctoProfiler.get_data(order_by: :calls, for: :trace)
  end

  def show(conn, %{"for" => "trace"}) do
    render conn, "trace.html", data: EctoProfiler.get_data(order_by: :average, for: :trace)
  end

  def show(conn, %{"order" => "time"}) do
    render conn, "module.html", data: EctoProfiler.get_data(order_by: :time, for: :module)
  end

  def show(conn, %{"order" => "calls"}) do
    render conn, "module.html", data: EctoProfiler.get_data(order_by: :calls, for: :module)
  end

  def show(conn, _) do
    render conn, "module.html", data: EctoProfiler.get_data(order_by: :average, for: :module)
  end
end

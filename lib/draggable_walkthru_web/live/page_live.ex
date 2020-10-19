defmodule DraggableWalkthruWeb.PageLive do
  use DraggableWalkthruWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    # this is hardcoded but would come from a datasource
    draggables = [
      %{id: "drag-me-0", text: "Drag Me 0"},
      %{id: "drag-me-1", text: "Drag Me 1"},
      %{id: "drag-me-2", text: "Drag Me 2"},
      %{id: "drag-me-3", text: "Drag Me 3"},
    ]

    socket =
      socket
      |> assign(:pool, draggables)
      |> assign(:drop_zone_a, [])
      |> assign(:drop_zone_b, [])

    {:ok, socket}
  end


end

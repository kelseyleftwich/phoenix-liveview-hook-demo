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

  def handle_event("dropped", %{"draggedId" => dragged_id, "dropzoneId" => drop_zone_id,"draggableIndex" => draggable_index}, %{assigns: assigns} = socket) do
    drop_zone_atom =
      [:pool, :drop_zone_a, :drop_zone_b]
      |> Enum.find(fn zone_atom -> to_string(zone_atom) == drop_zone_id end)

    if drop_zone_atom === nil do
     throw "invalid drop_zone_id"
    end

    dragged = find_dragged(assigns, dragged_id)

    socket =
      [:pool, :drop_zone_a, :drop_zone_b]
      |> Enum.reduce(socket, fn zone_atom, %{assigns: assigns} = accumulator ->
        updated_list =
          assigns
          |> update_list(zone_atom, dragged, drop_zone_atom, draggable_index)

        accumulator
          |> assign(zone_atom, updated_list)
      end)


    {:noreply, socket}
  end

  defp find_dragged(%{pool: pool, drop_zone_a: drop_zone_a, drop_zone_b: drop_zone_b}, dragged_id) do
    pool ++ drop_zone_a ++ drop_zone_b
      |> Enum.find(nil, fn draggable ->
        draggable.id == dragged_id
      end)
  end

  def update_list(assigns, list_atom, dragged, drop_zone_atom, draggable_index) when list_atom == drop_zone_atom  do
    assigns[list_atom]
    |> remove_dragged(dragged.id)
    |> List.insert_at(draggable_index, dragged)
  end

  def update_list(assigns, list_atom, dragged, drop_zone_atom, draggable_index) when list_atom != drop_zone_atom  do
    assigns[list_atom]
    |> remove_dragged(dragged.id)
  end

  def remove_dragged(list, dragged_id) do
    list
    |> Enum.filter(fn draggable ->
      draggable.id != dragged_id
    end)
  end

end

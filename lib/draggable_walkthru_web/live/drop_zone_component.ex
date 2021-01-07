
defmodule DraggableWalkthruWeb.PageLive.DropZoneComponent do
  use Phoenix.LiveComponent

  @impl true
  def render(assigns) do
    ~L"""
      <div class="dropzone grid gap-3 p-6 border-solid border-2 border-<%= @color %>-300 rounded-md my-6" id="<%= @drop_zone_id %>">
        <%= @title %>
        <%= for %{text: text, id: id} <- @draggables do %>
          <div draggable="true" id="<%= id %>" class="draggable p-4 bg-<%= @color %>-700 text-white"><%= text %></div>
        <% end %>
      </div>
    """
  end

end

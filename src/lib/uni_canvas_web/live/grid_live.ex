defmodule UniCanvasWeb.GridLive do
  use UniCanvasWeb, :live_view
  import Ecto.Query

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket), do: UniCanvas.Cell.subscribe()

    query = from(c in UniCanvas.Cell, order_by: [asc: c.id])
    {:ok, assign(socket, cells: UniCanvas.Repo.all(query))}
  end

  @impl true
  def render(assigns) do
    ~L"""
    <header class="">
      <div class="flex items-center justify-between border-b border-zinc-100 py-3">
        <div class="flex items-center">
          <div class="color-palette">
            <% colors = ~w(#000000 #070707 #0E0E0E #161616 #1D1D1D #242424 #2B2B2B #333333
  #3A3A3A #414141 #484848 #505050 #575757 #5E5E5E #656565 #6D6D6D
  #747474 #7B7B7B #828282 #8A8A8A #919191 #989898 #9F9F9F #A7A7A7
  #AEAEAE #B5B5B5 #BCBCBC #C4C4C4 #CBCBCB #D2D2D2 #D9D9D9 #E0E0E0
  #E8E8E8 #EFEFEF #F6F6F6 #FFFFFF #FF0000 #FF1900 #FF3200 #FF4B00
  #FF6400 #FF7D00 #FF9600 #FFAF00 #FFC800 #FFE100 #FFFF00 #E1FF00
  #C8FF00 #AFFF00 #96FF00 #7DFF00 #64FF00 #4BFF00 #32FF00 #19FF00
  #00FF00 #00FF19 #00FF32 #00FF4B #00FF64 #00FF7D #00FF96 #00FFAF
  #00FFC8 #00FFE1 #00FFFF #00E1FF #00C8FF #00AFFF #0096FF #007DFF
  #0064FF #004BFF #0032FF #0019FF #0000FF #1900FF #3200FF #4B00FF
  #6400FF #7D00FF #9600FF #AF00FF #C800FF #E100FF #FF00FF #FF00E1
  #FF00C8 #FF00AF #FF0096 #FF007D #FF0064 #FF004B #FF0032 #FF0019
  #400000 #400019 #400032 #40004B #400064 #40007D #400096 #4000AF
  #4000C8 #4000E1 #4000FF #4019FF #4032FF #404BFF #4064FF #407DFF
  #4096FF #40AFFF #40C8FF #40E1FF #40FFFF #40E1FF #40C8FF #40AFFF
  #4096FF #407DFF #4064FF #404BFF #4032FF #4019FF #4000FF #4000E1
  #4000C8 #4000AF #400096 #40007D #400064 #40004B #400032 #400019
    )%>
            <%= for color_code <- colors do %>
              <div class="color" style="background-color: <%= color_code %>" phx-click="select_color" phx-value-color="<%= color_code %>"></div>
            <% end %>
          </div>
        </div>
      </div>
    </header>
    <div class="grid">
      <%= for cell <- @cells do %>
        <div
          class="cell"
          style="background-color: <%= cell.color %>"
          phx-click="change_color"
          phx-value-id="<%= cell.id %>"
        ></div>
      <% end %>
    </div>
    """
  end

  @impl true
  def handle_event("change_color", %{"id" => id}, socket) do
    target_id = String.to_integer(id)
    updated_color = socket.assigns.selected_color || "#000000"
    target_cell = UniCanvas.Repo.get(UniCanvas.Cell, target_id)

    case UniCanvas.Cell.update(target_cell, %{color: updated_color}) do
      {:ok, updated_cell} ->
        query = from(c in UniCanvas.Cell, order_by: [asc: c.id])
        {:noreply, assign(socket, cells: UniCanvas.Repo.all(query))}
      {:error, changeset} ->
        IO.inspect(changeset.errors)
        {:noreply, socket}
    end
  end

  def handle_event("select_color", %{"color" => color}, socket) do
    {:noreply, assign(socket, selected_color: color)}
  end

  def handle_info({:updated_cell, cell}, socket) do
    query = from(c in UniCanvas.Cell, order_by: [asc: c.id])
    {:noreply, assign(socket, cells: UniCanvas.Repo.all(query))}
  end
end

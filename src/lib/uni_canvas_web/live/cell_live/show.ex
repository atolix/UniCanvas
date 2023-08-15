defmodule UniCanvasWeb.CellLive.Show do
  use UniCanvasWeb, :live_view

  alias UniCanvas.Grid

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:cell, Grid.get_cell!(id))}
  end

  defp page_title(:show), do: "Show Cell"
  defp page_title(:edit), do: "Edit Cell"
end

defmodule DraggableWalkthru.Repo do
  use Ecto.Repo,
    otp_app: :draggable_walkthru,
    adapter: Ecto.Adapters.Postgres
end

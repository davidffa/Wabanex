defmodule WabanexWeb.Resolvers.Training do
  def create(%{input: params}, _ctx), do: Wabanex.Training.Create.call(params)
end

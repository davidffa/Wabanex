defmodule Wabanex.Training.Create do
  alias Wabanex.{Repo, Training}

  def call(params) do
    params
    |> Training.changeset()
    |> Repo.insert()
  end
end

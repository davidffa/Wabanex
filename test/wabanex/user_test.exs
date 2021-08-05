defmodule Wabanex.UserTest do
  use Wabanex.DataCase, async: true

  alias Wabanex.User

  describe "changeset/1" do
    test "when all params are valid, returns a valid changeset" do
      params = %{name: "David", email: "david@teste.com", password: "12345678"}

      response = User.changeset(params)

      assert %Ecto.Changeset{
        valid?: true,
        changes: %{email: "david@teste.com", name: "David", password: "12345678"},
        errors: []
      } = response
    end

    test "when there are invalid params, returns an invalid changeset" do
      params = %{name: "D", email: "david@teste.com"}

      response = User.changeset(params)

      expected_response = %{
        name: ["should be at least 2 character(s)"],
        password: ["can't be blank"]
      }

      assert errors_on(response) == expected_response
    end
  end
end

defmodule WabanexWeb.SchemaText do
  use WabanexWeb.ConnCase, async: true

  alias Wabanex.User
  alias Wabanex.Users.Create

  describe "users queries" do
    test "when a valid id is given, returns the user", %{conn: conn} do
      params = %{email: "david@test.com", name: "David", password: "12345678"}

      {:ok, %User{id: user_id}} = Create.call(params)

      query = """
        {
          getUser(id: "#{user_id}") {
            name
            email
          }
        }
      """

      response =
        conn
        |> post("/api/graphql", %{query: query})
        |> json_response(:ok)

      expected_response = %{
        "data" => %{
          "getUser" => %{
            "email" => "david@test.com",
            "name" => "David"
          }
        }
      }

      assert response == expected_response
    end

    test "when a invalid id is given, returns an error", %{conn: conn} do
      query = """
        {
          getUser(id: "wrong_id") {
            name
            email
          }
        }
      """

      response =
        conn
        |> post("/api/graphql", %{query: query})
        |> json_response(:ok)

      expected_response = %{
        "errors" => [
          %{
            "locations" => [
              %{
                "column" => 13,
                "line" => 2
              }
            ],
            "message" => "Argument \"id\" has invalid value \"wrong_id\"."
          }
        ]
      }

      assert response == expected_response
    end
  end

  describe "users mutations" do
    test "when all params are valid, creates the user", %{conn: conn} do
      mutation = """
        mutation {
          createUser(input: {
            name: "David", email: "david@test.com", password: "12345678"
          }) {
            id
            name
          }
        }
      """

      response =
        conn
        |> post("/api/graphql", %{query: mutation})
        |> json_response(:ok)

      assert %{"data" => %{"createUser" => %{"id" => _id, "name" => "David"}}} = response
    end
  end
end

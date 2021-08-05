defmodule Wabanex.IMCTest do
  use ExUnit.Case, async: true

  alias Wabanex.IMC

  describe "calculate/1" do
    test "when the file exists, returns the data" do
      params = %{"filename" => "students.csv"}

      response = IMC.calculate(params)

      expected_resposne =
        {:ok,
          %{
            "David" => 24.074074074074073,
            "Teste" => 24.221453287197235
          }
        }

      assert expected_resposne == response
    end

    test "when the wrong filename is given, returns an error" do
      params = %{"filename" => "wrong.csv"}

      response = IMC.calculate(params)

      expected_resposne = {:error, "Error while opening the file"}

      assert expected_resposne == response
    end
  end
end

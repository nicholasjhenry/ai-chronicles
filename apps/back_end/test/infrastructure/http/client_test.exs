defmodule Infrastructure.Http.ClientTest do
  use ExUnit.Case

  alias Infrastructure.Http

  setup_all do
    {:ok, _} = Registry.start_link(keys: :unique, name: Infrastructure.Registry)

    :ok
  end

  @tag :external
  test "handling a request" do
    http_client = Http.Client.create()

    result = Http.Client.post(http_client, "https://postman-echo.com/post", %{body: :test})

    assert {:ok, actual_response} = result
    assert actual_response.status_code == 200
    assert {"Content-Type", "application/json; charset=utf-8"} in actual_response.headers
    assert %{"data" => %{"body" => "test"}} = actual_response.body
  end

  describe "nullability" do
    test "default response", %{test: test} do
      http_client = Http.Client.create_null()
      OutputTracking.track_output(test, [:http_client, :post])

      result = Http.Client.post(http_client, "https://NOT_CONNECTED/post", %{body: :test})

      expected_response = Infrastructure.Http.Controls.Response.NotImplemented.example()

      expected_request = Infrastructure.Http.Controls.Request.example()
      assert_receive {[:http_client, :post], ^expected_request}

      assert {:ok, actual_response} = result
      assert actual_response.status_code == expected_response.status_code
      assert {"Content-Type", "application/json; charset=utf-8"} in actual_response.headers
      assert expected_response.body == actual_response.body
    end

    test "configurable response" do
      url = "https://NOT_CONNECTED/post"

      responses = [
        {url, Infrastructure.Http.Controls.Response.example()}
      ]

      http_client = Http.Client.create_null(responses: responses)

      result = Http.Client.post(http_client, url, %{body: :test})

      assert {:ok, actual_response} = result
      assert actual_response.status_code == 200
      assert {"Content-Type", "application/json; charset=utf-8"} in actual_response.headers
      assert %{"hello" => "world"} == actual_response.body
    end
  end
end

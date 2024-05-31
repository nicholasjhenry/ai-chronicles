defmodule Infrastructure.OpenAi.ClientTest do
  use ExUnit.Case

  alias Infrastructure.Http
  alias Infrastructure.OpenAi

  @json Infrastructure.Http.Request.Headers.ContentType.json()
  @url "https://api.openai.com/v1/chat/completions"

  test "handling a request", %{test: test} do
    body = OpenAi.Controls.Response.example("This is a test!")
    responses = [{@url, Http.Response.new(status_code: 200, body: body)}]
    OutputTracking.track_output(test, [:http_client, :post])

    http_client = Http.Client.create_null(responses: responses)
    open_ai_client = OpenAi.Client.create(http_client: http_client, api_key: "my_api_key")

    text = "Say this is a test!"
    result = OpenAi.Client.prompt(open_ai_client, text)

    body = %{
      "model" => "gpt-3.5-turbo",
      "messages" => [%{"content" => "Say this is a test!", "role" => "user"}],
      "temperature" => 0.7
    }

    headers = [@json, {"Authorization", "Bearer my_api_key"}]

    request = Http.Request.new(body: body, headers: headers, url: @url)
    assert_receive {[:http_client, :post], ^request}

    assert {:ok, response} = result
    assert %{"id" => _id} = response.body
  end
end

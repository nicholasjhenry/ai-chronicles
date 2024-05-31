defmodule Infrastructure.OpenAi.Client do
  alias Infrastructure.Http

  alias Infrastructure.OpenAi.Controls
  alias Infrastructure.OpenAi.Request

  defstruct [:http_client, :api_key]

  @url "https://api.openai.com/v1/chat/completions"

  def create_null(attrs \\ []) do
    attrs = Keyword.validate!(attrs, [:response])

    {text, attrs} = Keyword.pop(attrs, :response, "This is a test")
    body = Controls.Response.example(text)
    responses = [{@url, Http.Response.new(status_code: 200, body: body)}]

    http_client = Http.Client.create_null(responses: responses)
    default_attrs = %{http_client: http_client, api_key: "SOME_API_KEY"}

    attrs
    |> Enum.into(default_attrs)
    |> Map.to_list()
    |> create()
  end

  def create(attrs \\ []) do
    attrs = Keyword.validate!(attrs, [:http_client, :api_key])

    default_attrs = %{http_client: Http.Client.create()}
    attrs = Enum.into(attrs, default_attrs)

    struct!(__MODULE__, attrs)
  end

  def prompt(open_ai_client, text) do
    OutputTracking.emit([:open_ai_client, :prompt], %{text: text})

    message = Request.Body.Message.new(role: "user", content: text)

    request_body =
      Request.Body.new(
        model: "gpt-3.5-turbo",
        messages: [message],
        temperature: 0.7
      )

    headers = [
      {"Authorization", "Bearer #{open_ai_client.api_key}"}
    ]

    Http.Client.post(open_ai_client.http_client, @url, request_body, headers)
  end
end

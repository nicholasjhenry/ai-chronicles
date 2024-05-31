defmodule Infrastructure.Http.Client do
  defstruct [:http_poison]

  alias Infrastructure.Http

  def track_output(handler_id) do
    OutputTracking.track_output(handler_id, [:http_client, :post])
  end

  defmodule HttpPoisonStub do
    alias Infrastructure.Http.Controls

    def post(url, body, headers) do
      request = Http.Request.new(url: url, headers: headers, body: Jason.decode!(body))
      OutputTracking.emit([:http_client, :post], request)

      response = url |> get_response |> to_httpoison

      {:ok, response}
    end

    defp get_response(url) do
      ConfigurableResponses.get_response(HttpPoisonStub, url) ||
        Controls.Response.NotImplemented.example()
    end

    defp to_httpoison(response) when is_struct(response) do
      attrs = %{
        status_code: response.status_code,
        headers: response.headers,
        body: Jason.encode!(response.body)
      }

      struct!(HTTPoison.Response, attrs)
    end
  end

  def create_null(attrs \\ []) do
    {responses, attrs} = Keyword.pop(attrs, :responses, [])
    ConfigurableResponses.start_link(HttpPoisonStub, responses)

    default_attrs = %{http_poison: HttpPoisonStub}
    attrs = Enum.into(attrs, default_attrs)
    struct!(__MODULE__, attrs)
  end

  def create(attrs \\ []) do
    default_attrs = %{http_poison: HTTPoison}

    attrs = Enum.into(attrs, default_attrs)

    struct!(__MODULE__, attrs)
  end

  def post(http_client, url, body, custom_headers \\ []) do
    headers =
      [
        Http.Request.Headers.ContentType.json()
      ] ++ custom_headers

    with {:ok, httpoison_response} <-
           http_client.http_poison.post(url, Jason.encode!(body), headers) do
      response =
        Http.Response.new(
          status_code: httpoison_response.status_code,
          headers: httpoison_response.headers,
          body: Jason.decode!(httpoison_response.body)
        )

      {:ok, response}
    end
  end
end

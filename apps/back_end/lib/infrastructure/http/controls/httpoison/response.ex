defmodule Infrastructure.Http.Controls.HTTPoison.Response do
  alias Infrastructure.Http.Controls

  def example(attrs \\ []) do
    body = body()

    default_attrs = %{
      status_code: 200,
      body: body,
      headers: headers(body),
      request_url: "https://postman-echo.com/post",
      request: Controls.HttPoison.Request.example()
    }

    attrs = Enum.into(attrs, default_attrs)

    struct!(HTTPoison.Response, attrs)
  end

  def body do
    "{\n  \"args\": {},\n  \"data\": {\n    \"body\": \"test\"\n  },\n  \"files\": {},\n  \"form\": {},\n  \"headers\": {\n    \"x-forwarded-proto\": \"https\",\n    \"x-forwarded-port\": \"443\",\n    \"host\": \"postman-echo.com\",\n    \"x-amzn-trace-id\": \"Root=1-66145ea7-3ebcd1fc181f739359ac9b23\",\n    \"content-length\": \"16\",\n    \"user-agent\": \"hackney/1.20.1\",\n    \"content-type\": \"application/json\"\n  },\n  \"json\": {\n    \"body\": \"test\"\n  },\n  \"url\": \"https://postman-echo.com/post\"\n}"
  end

  def headers(body) do
    date_time = "Mon, 08 Apr 2024 21:16:23 GMT"

    [
      {"Date", date_time},
      {"Content-Type", "application/json; charset=utf-8"},
      {"Content-Length", String.length(body)},
      {"Connection", "keep-alive"},
      {"ETag", "DUMMY_ETAG"},
      {"set-cookie", "sails.sid=DUMMY_COOKIE; Path=/; HttpOnly"}
    ]
  end
end

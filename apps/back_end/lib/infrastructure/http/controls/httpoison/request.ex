defmodule Infrastructure.Http.Controls.HttPoison.Request do
  def example do
    url = "https://postman-echo.com/post"
    body = "{\"body\": \"test\"}"

    %HTTPoison.Request{
      method: :post,
      url: url,
      headers: [{"Content-Type", "application/json"}],
      body: body,
      params: %{},
      options: []
    }
  end
end

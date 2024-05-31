defmodule Infrastructure.Http.Controls.HTTPoison.Response.NotImplemented do
  @json Infrastructure.Http.Response.Headers.ContentType.json()

  def example do
    %HTTPoison.Response{
      status_code: 503,
      headers: [@json],
      body: Jason.encode!(%{error: "Not implemented"})
    }
  end
end

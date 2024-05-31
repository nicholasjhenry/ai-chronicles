defmodule Infrastructure.Http.Controls.Response.NotImplemented do
  alias Infrastructure.Http.Response

  def example do
    Response.new(
      status_code: 503,
      headers: [{"Content-Type", "application/json; charset=utf-8"}],
      body: %{"error" => "Not implemented"}
    )
  end
end

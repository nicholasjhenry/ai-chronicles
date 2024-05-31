defmodule Infrastructure.Http.Controls.Response do
  alias Infrastructure.Http.Response

  def example do
    Response.new(
      status_code: 200,
      headers: [{"Content-Type", "application/json; charset=utf-8"}],
      body: %{"hello" => "world"}
    )
  end
end

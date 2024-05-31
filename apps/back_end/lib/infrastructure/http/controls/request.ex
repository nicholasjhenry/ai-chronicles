defmodule Infrastructure.Http.Controls.Request do
  alias Infrastructure.Http.Request

  def example do
    Request.new(
      url: "https://NOT_CONNECTED/post",
      headers: [{"Content-Type", "application/json"}],
      body: %{"body" => "test"}
    )
  end
end

api_key = System.fetch_env!("OPENAI_API_KEY")
open_ai = Infrastructure.OpenAi.Client.create(api_key: api_key)
data = "Say Hello World!"

{:ok, %{status_code: 200} = response} = Infrastructure.OpenAi.Client.prompt(open_ai, data)

IO.puts(List.first(response.body["choices"])["message"]["content"])

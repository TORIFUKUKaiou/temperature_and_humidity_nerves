defmodule TemperatureAndHumidityNerves.Worker do
  require Logger

  @url "https://aht20.torifuku-kaiou.tokyo/values"
  @headers [{"Content-Type", "application/json"}]

  def run do
    {:ok, {temperature, humidity}} = TemperatureAndHumidityNerves.Aht20.read()

    inspect({temperature, humidity}) |> Logger.debug()

    post(temperature, humidity)
  end

  defp post(temperature, humidity) do
    time = Timex.now() |> Timex.to_unix()
    json = Jason.encode!(%{value: %{temperature: temperature, humidity: humidity, time: time}})
    HTTPoison.post(@url, json, @headers)
  end
end

defmodule TemperatureAndHumidityNerves.Worker do
  require Logger

  @name "awesome"
  @headers [{"Content-Type", "application/json"}]

  def run do
    {:ok, {temperature, humidity}} = TemperatureAndHumidityNerves.Aht20.read()

    inspect({temperature, humidity}) |> Logger.debug()

    post_temperature(temperature)
    post_humidity(humidity)
  end

  defp post_temperature(value) do
    post(value, "https://phx.japaneast.cloudapp.azure.com/temperatures")
  end

  defp post_humidity(value) do
    post(value, "https://phx.japaneast.cloudapp.azure.com/humidities")
  end

  defp post(value, url) do
    time = Timex.now() |> Timex.to_unix()
    json = Jason.encode!(%{value: %{name: @name, value: value, time: time}})
    HTTPoison.post(url, json, @headers)
  end
end

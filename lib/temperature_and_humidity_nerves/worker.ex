defmodule TemperatureAndHumidityNerves.Worker do
  require Logger

  # need to fix following 2 lines according to your environment
  @url "https://hogehoge.japaneast.cloudapp.azure.com/values"
  @name "awesome"

  @headers [{"Content-Type", "application/json"}]

  def run do
    {:ok, {temperature, humidity}} = TemperatureAndHumidityNerves.Aht20.read()

    inspect({temperature, humidity}) |> Logger.info()

    post(temperature, humidity)
  end

  defp post(temperature, humidity) do
    json = Jason.encode!(%{value: %{name: @name, temperature: temperature, humidity: humidity}})

    HTTPoison.post(@url, json, @headers)
  end
end

# TemperatureAndHumidityNerves

[TORIFUKUKaiou/hello_iot_cloud](https://github.com/TORIFUKUKaiou/hello_iot_cloud)のPhoenix Webアプリと共に利用します．
Nervesデバイス（Raspberry Pi）から[Grove AHT20 I2C](https://jp.seeedstudio.com/Grove-AHT20-I2C-Industrial-grade-temperature-and-humidity-sensor-p-4497.html)の温湿度値を打ち上げます．

## 利用方法

1. [./lib/temperature_and_humidity_nerves/worker.ex](https://github.com/TORIFUKUKaiou/temperature_and_humidity_nerves/blob/main/lib/temperature_and_humidity_nerves/worker.ex#L4-L6)の2行を変更してください．  
    - ローカルPCに[TORIFUKUKaiou/hello_iot_cloud](https://github.com/TORIFUKUKaiou/hello_iot_cloud)を立ち上げている場合（IPアドレスは例）  
      ```
      @url "http://192.168.1.2/values"
      @name "awesome"
      ```
    - 2021年11月30日までは，下記のURLで遊んでいただいて構いません．
      ```
      @url "https://nervesjp-dsf2021.japaneast.cloudapp.azure.com/values"
      @name "awesome"
      ```
2. いつものようにNervesのビルドなり書き込みなりを行います．
    ```
    $ export MIX_TARGET=rpi3
    $ mix deps.get
    $ mix firmware
    ### SDカードに書き込みの場合
    $ mix burn 
    ### ネットワーク越しにアップデートの場合
    $ mix upload 
    ```
3. Nerves IExで値が取れていることを確認してみてください．
    ```
    $ ssh nerves.local 
    Interactive Elixir (1.11.2) - press Ctrl+C to exit (type h() ENTER for help)
    Toolshed imported. Run h(Toolshed) for more info.
    RingLogger is collecting log messages from Elixir and Linux. To see the
    messages, either attach the current IEx session to the logger:
    
      RingLogger.attach
    
    or print the next messages in the log:
    
      RingLogger.next
    
    iex(1)> RingLogger.attach(level: :info)
    :ok
            
    03:57:47.536 [info]  {23.9, 56.7}
            
    03:57:48.535 [info]  {23.9, 56.7}
            
    03:57:49.535 [info]  {23.9, 56.7}
    ```
4. Webページで打ち上がっていることが確認できます :rocket:
    - ローカルPCに[TORIFUKUKaiou/hello_iot_cloud](https://github.com/TORIFUKUKaiou/hello_iot_cloud)を立ち上げている場合（IPアドレスは例）  
    http://192.168.1.2/temperature-chart
    - 2021年11月30日までは，下記で打ち上げ結果を確認できます．  
    https://nervesjp-dsf2021.japaneast.cloudapp.azure.com/temperature-chart

## Targets

Nerves applications produce images for hardware targets based on the
`MIX_TARGET` environment variable. If `MIX_TARGET` is unset, `mix` builds an
image that runs on the host (e.g., your laptop). This is useful for executing
logic tests, running utilities, and debugging. Other targets are represented by
a short name like `rpi3` that maps to a Nerves system image for that platform.
All of this logic is in the generated `mix.exs` and may be customized. For more
information about targets see:

https://hexdocs.pm/nerves/targets.html#content

## Getting Started

To start your Nerves app:
  * `export MIX_TARGET=my_target` or prefix every command with
    `MIX_TARGET=my_target`. For example, `MIX_TARGET=rpi3`
  * Install dependencies with `mix deps.get`
  * Create firmware with `mix firmware`
  * Burn to an SD card with `mix firmware.burn`

## Learn more

  * Official docs: https://hexdocs.pm/nerves/getting-started.html
  * Official website: https://nerves-project.org/
  * Forum: https://elixirforum.com/c/nerves-forum
  * Discussion Slack elixir-lang #nerves ([Invite](https://elixir-slackin.herokuapp.com/))
  * Source: https://github.com/nerves-project/nerves

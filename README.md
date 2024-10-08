# delay_times

[![Package Version](https://img.shields.io/hexpm/v/delay_times)](https://hex.pm/packages/delay_times)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/delay_times/)

```sh
gleam add delay_times
```
```gleam
import delay_times
import gleam/io

pub fn main() {
  delay_times.new(120.0, delay_times.Normal, delay_times.Ms) |> io.debug
  // DelayTimes(2.0e3, 1.0e3, 500.0, 250.0, 125.0, 62.5, 31.25, 15.625)
}
```

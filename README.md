# spell_out

[![Package Version](https://img.shields.io/hexpm/v/spell_out)](https://hex.pm/packages/spell_out)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/spell_out/)

```sh
gleam add spell_out@1
```
```gleam
import gleam/io
import spell_out

pub fn main() {
  io.println(spell_out.spell_out(123_456_789))
  // one-hundred-twenty-three-million four-hundred-fifty-six-thousand seven-hundred-eigthy-nine
}
```

Further documentation can be found at <https://hexdocs.pm/spell_out>.

## Development

```sh
gleam run   # Run the project
gleam test  # Run the tests
```

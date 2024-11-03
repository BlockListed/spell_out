import gleam/string
import gleam/int
import gleam/iterator
import gleam/list

pub fn spell_out(i: Int) -> String {
  let assert Ok(digits) = int.digits(i, 10)

  spell_out_digits(digits)
}

fn spell_out_digits(digits: List(Int)) -> String {
  case digits {
    [0] -> "zero"
    [o] ->
      case o {
        1 -> "one"
        2 -> "two"
        3 -> "three"
        4 -> "four"
        5 -> "five"
        6 -> "six"
        7 -> "seven"
        8 -> "eight"
        9 -> "nine"
        _ -> panic
      }
    [0, o] -> spell_out_digits([o])
    [1, 0] -> "ten"
    [1, 1] -> "eleven"
    [1, 2] -> "twelve"
    [1, 3] -> "thirteen"
    [1, 4] -> "fourteen"
    [1, 5] -> "fifthteen"
    [1, 6] -> "sixteen"
    [1, 7] -> "seventeen"
    [1, 8] -> "eighteen"
    [1, 9] -> "nineteen"
    [t, o] -> {
      let tens = case t {
        1 -> panic
        2 -> "twenty"
        3 -> "thirty"
        4 -> "fourty"
        5 -> "fifty"
        6 -> "sixty"
        7 -> "seventy"
        8 -> "eighty"
        9 -> "ninety"
        _ -> panic
      }

      case o {
        0 -> tens
        o -> tens <> "-" <> spell_out_digits([o])
      }
    }
    [0, t, o] -> spell_out_digits([t, o])
    [h, t, o] -> {
      let hundred = spell_out_digits([h]) <> "-hundred"

      case t, o {
        0, 0 -> hundred
        t, o -> hundred <> "-" <> spell_out_digits([t, o])
      }
    }
    digits -> {
      let chunks =
        digits
        |> list.reverse
        |> list.sized_chunk(3)
        |> list.reverse
        |> list.map(list.reverse)

      chunks
      |> list.reverse
      |> iterator.from_list
      |> iterator.index
      |> iterator.map(fn(e) {
        let #(digits, n) = e

        case digits {
          [0, 0, 0] -> ""
          digits -> 
        case n {
          0 -> spell_out_digits(digits)
          n -> {
            let short_scale = case n {
              1 -> "thousand"
              2 -> "million"
              3 -> "billion"
              4 -> "trillion"
              5 -> "quadrillion"
              6 -> "quintillion"
              7 -> "sextillion"
              8 -> "septillion"
              9 -> "octillion"
              10 -> "nonillion"
              11 -> "decillion"
              _ -> panic
            }

            spell_out_digits(digits) <> "-" <> short_scale
          }
        }
        }

      })
      |> iterator.fold("", fn(acc, d) {
        d <> " " <> acc
      })
      |> string.trim_right
    }
  }
}

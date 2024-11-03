import spell_out
import gleeunit
import gleeunit/should

pub fn main() {
  gleeunit.main()
}

pub fn full_test() {
  spell_out.spell_out(123_456_789)
    |> should.equal("one-hundred-twenty-three-million four-hundred-fifty-six-thousand seven-hundred-eighty-nine")
}

pub fn zeros_one_test() {
  spell_out.spell_out(123_456_000)
    |> should.equal("one-hundred-twenty-three-million four-hundred-fifty-six-thousand")
}

pub fn zeros_two_test() {
  spell_out.spell_out(123_000_000)
    |> should.equal("one-hundred-twenty-three-million")
}

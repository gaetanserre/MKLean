/-
 - Created in 2023 by Gaëtan Serré
-/

import MKLean.Create_Project
import MKLean.Update


def main (argv : List String) : IO Unit :=
  let usage := "Usage: mklean {update | <project directory> [math?]}"

  let argv := argv.toArray
  if argv.size < 1 then
    throw <| IO.userError s!"Error: no project directory specified.\n{usage}."
  else
    match argv with
    | #["update"] => update
    | #[n] => make_lean_project n false
    | #[n, "math"]
    | #[n, "m"] => make_lean_project n true
    | _ => throw <| IO.userError s!"Error: too many arguments.\n{usage}."

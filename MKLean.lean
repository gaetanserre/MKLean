/-
 - Created in 2023 by Gaëtan Serré
-/

import MKLean.Create_Project

def main (argv : List String) : IO Unit :=
  let usage := "Usage: mklean <project directory> [math?]"

  let argv := argv.toArray
  if argv.size < 1 then
    IO.println s!"Error: no project directory specified.\n{usage}."
  else
    match argv with
    | #[s] => make_lean_project s false
    | #[s, "math"]
    | #[s, "m"] => make_lean_project s true
    | _ => IO.println s!"Error: too many arguments.\n{usage}."

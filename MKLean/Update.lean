/-
 - Created in 2023 by Gaëtan Serré
-/

import MKLean.Create_Project

def need_mathlib : IO Bool :=
  let aux :=
    try
      IO.FS.readFile ".lake/packages/mathlib/Mathlib.lean"
    catch _ =>
      pure ""
  aux >>= (λ a ↦ pure (a != ""))

def update : IO Unit := do
  exe_cmd "rm" #["-rf", ".lake", "lake-manifest.json"]
  exe_cmd "lake" #["clean"]
  exe_cmd "lake" #["update"]
  need_mathlib >>= (if . then
    exe_cmd "lake" #["exe", "cache", "get"] else pure ())

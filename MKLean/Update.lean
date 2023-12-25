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

def update : IO Bool :=
  let s := need_mathlib
  s

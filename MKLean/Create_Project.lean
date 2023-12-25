/-
 - Created in 2023 by Gaëtan Serré
-/

import MKLean.Utils

def Stringofargs (args : Array String) : String :=
  let rec aux (args : List String) :=
    match args with
    | [] => ""
    | hd :: tl =>
      hd ++ " " ++ aux tl
  aux args.data

def lake_call (args_cwd : Array String × Option String) : IO Unit := do
  let (args, cwd) := args_cwd
  IO.println s!"+ lake {Stringofargs args}"
  sys_call "lake" args cwd >>= IO.print

def make_lean_project (project_dir : String) (need_mathlib : Bool) : IO Unit :=
  let args_cwd := [
    (#["+leanprover/lean4:v4.4.0-rc1", "new", project_dir] ++ if need_mathlib then #["math"] else #[], none),
    (#["update"], some project_dir)
  ]

  let args_cwd := if need_mathlib then (args_cwd ++ [(#["exe", "cache", "get"], some project_dir)])
  else args_cwd

  args_cwd.iter lake_call

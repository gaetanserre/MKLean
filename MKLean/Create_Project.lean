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

def exe_cmd (exe : String) (args : Array String) (cwd : Option String := none) : IO Unit := do
  IO.println s!"+ {exe} {Stringofargs args}"
  sys_call exe args cwd >>= IO.print

def lake_call (args_cwd : Array String × Option String) : IO Unit :=
  let (args, cwd) := args_cwd
  exe_cmd "lake" args cwd

def make_lean_project (project_dir : String) (need_mathlib : Bool) : IO Unit :=
  let args_cwd := [
    (#["+leanprover/lean4:v4.8.0-rc2", "new", project_dir] ++ if need_mathlib then #["math"] else #[], none),
    (#["update"], some project_dir)
  ]

  let args_cwd := if need_mathlib then (args_cwd ++ [(#["exe", "cache", "get"], some project_dir)])
  else args_cwd

  args_cwd.iter lake_call

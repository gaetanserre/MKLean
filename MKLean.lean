/-
 - Created in 2023 by Gaëtan Serré
-/

namespace List

def iter {α : Type u} (l : List α) (f : α → IO Unit) : IO Unit :=
  let rec aux (l : List α) : IO Unit := do
    match l with
    | [] => pure ()
    | hd :: tl =>
      f hd
      aux tl
  aux l
end List

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
  IO.Process.run {cmd := "lake", args := args, cwd := cwd} >>= IO.print

def make_lean_project (project_dir : String) (need_mathlib : Bool) : IO Unit :=
  let args_cwd := [
    (#["+leanprover/lean4:v4.4.0-rc1", "new", project_dir] ++ if need_mathlib then #["math"] else #[], none),
    (#["update"], some project_dir)
  ]

  let args_cwd := if need_mathlib then (args_cwd ++ [(#["exe", "cache", "get"], some project_dir)])
  else args_cwd

  args_cwd.iter lake_call


def main (argv : List String) : IO Unit :=
  let argv := argv.toArray
  if argv.size < 1 then
    IO.println "Error: no project directory specified.\nUsage: mklean <project directory> [math?]."
  else if argv.size == 1 then
    make_lean_project (argv.get! 0) false
  else
    let need_mathlib := argv.get! 1 == "math" || argv.get! 1 == "m"
    make_lean_project (argv.get! 0) need_mathlib

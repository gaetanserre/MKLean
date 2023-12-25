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

def sys_call (cmd : String) (args : Array String) (cwd : Option String) : IO String :=
  IO.Process.run {cmd := cmd, args := args, cwd := cwd}

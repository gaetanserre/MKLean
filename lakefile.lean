import Lake
open Lake DSL

package «mklean» where
  -- add package configuration options here

lean_lib «MKLean» where
  -- add library configuration options here

@[default_target]
lean_exe «mklean» where
  root := `MKLean

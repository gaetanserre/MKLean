import Lake
open Lake DSL

package «MKLean» where
  -- add package configuration options here

@[default_target]
lean_exe «mklean» where
  root := `MKLean

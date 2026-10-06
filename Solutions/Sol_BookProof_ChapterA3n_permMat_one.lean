-- Generated from ChapterA3n.lean — solution of BookProof.ChapterA3n.permMat_one
import Mathlib
import Definitions.Def_ChapterA3n
open BookProof.ChapterA3n



open Matrix
open scoped BigOperators


open BookProof.ChapterA3 BookProof.ChapterA3j

set_option maxHeartbeats 1000000 in
theorem solution {N : ℕ} : permMat (1 : Equiv.Perm (Fin N)) = 1 := by

  ext a b; simp [permMat, Matrix.one_apply];
  grind

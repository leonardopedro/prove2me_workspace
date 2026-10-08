-- Generated from ChapterA3f.lean — theorem BookProof.ChapterA3.hasDerivAt_det_line
import Mathlib
import Definitions.Def_ChapterA3f
import Definitions.Def_ChapterA3
open BookProof.ChapterA3


open Matrix NormedSpace
open scoped Norms.Operator


variable {n : ℕ}


theorem BookProof.ChapterA3.hasDerivAt_det_line (A : Matrix (Fin n) (Fin n) ℝ) :
    HasDerivAt (fun t : ℝ => (1 + t • A).det) A.trace 0 := by sorry

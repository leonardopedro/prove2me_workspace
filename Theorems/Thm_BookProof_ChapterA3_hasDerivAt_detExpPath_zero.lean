-- Generated from ChapterA3f.lean — theorem BookProof.ChapterA3.hasDerivAt_detExpPath_zero
import Mathlib
import Definitions.Def_ChapterA3f
import Definitions.Def_ChapterA3
open BookProof.ChapterA3


open Matrix NormedSpace
open scoped Norms.Operator


variable {n : ℕ}


theorem BookProof.ChapterA3.hasDerivAt_detExpPath_zero (A : Matrix (Fin n) (Fin n) ℝ) :
    HasDerivAt (detExpPath A) A.trace 0 := by sorry

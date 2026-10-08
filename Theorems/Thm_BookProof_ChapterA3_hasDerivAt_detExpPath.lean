-- Generated from ChapterA3f.lean — theorem BookProof.ChapterA3.hasDerivAt_detExpPath
import Mathlib
import Definitions.Def_ChapterA3f
import Definitions.Def_ChapterA3
open BookProof.ChapterA3


open Matrix NormedSpace
open scoped Norms.Operator


variable {n : ℕ}


theorem BookProof.ChapterA3.hasDerivAt_detExpPath (A : Matrix (Fin n) (Fin n) ℝ) (t : ℝ) :
    HasDerivAt (detExpPath A) (A.trace * detExpPath A t) t := by sorry

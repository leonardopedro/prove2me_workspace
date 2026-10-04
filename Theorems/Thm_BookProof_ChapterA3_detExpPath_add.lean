-- Generated from ChapterA3f.lean — theorem BookProof.ChapterA3.detExpPath_add
import Mathlib
import Definitions.Def_ChapterA3f
import Definitions.Def_ChapterA3
open BookProof.ChapterA3

variable {n : ℕ}


open Matrix NormedSpace
open scoped Norms.Operator



theorem BookProof.ChapterA3.detExpPath_add (A : Matrix (Fin n) (Fin n) ℝ) (s t : ℝ) :
    detExpPath A (s + t) = detExpPath A s * detExpPath A t := by sorry

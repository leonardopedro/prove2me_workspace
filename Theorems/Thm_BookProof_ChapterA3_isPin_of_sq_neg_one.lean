-- Generated from ChapterA3d.lean — theorem BookProof.ChapterA3.isPin_of_sq_neg_one
import Mathlib
import Definitions.Def_ChapterA3d
import Definitions.Def_ChapterA3c
import Definitions.Def_ChapterA3
open BookProof.ChapterA3


open Matrix

theorem BookProof.ChapterA3.isPin_of_sq_neg_one {S : Matrix (Fin 4) (Fin 4) ℝ} (h : S * S = -1)
    (hL : ∃ Λ, HasLambda S Λ) : IsPin S := by sorry

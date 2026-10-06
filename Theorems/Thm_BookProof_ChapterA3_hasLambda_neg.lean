-- Generated from ChapterA3c.lean — theorem BookProof.ChapterA3.hasLambda_neg
import Mathlib
import Definitions.Def_ChapterA3c
import Definitions.Def_ChapterA3
open BookProof.ChapterA3


open Matrix
open scoped ComplexConjugate

theorem BookProof.ChapterA3.hasLambda_neg {S Λ : Matrix (Fin 4) (Fin 4) ℝ} (h : HasLambda S Λ) :
    HasLambda (-S) Λ := by sorry

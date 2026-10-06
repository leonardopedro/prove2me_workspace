-- Generated from ChapterWeakValue.lean — theorem BookProof.ChapterWeakValue.weakValue_proj
import Mathlib
import Definitions.Def_ChapterWeakValue
open BookProof.ChapterWeakValue

variable {n : ℕ}


open scoped BigOperators Matrix



theorem BookProof.ChapterWeakValue.weakValue_proj (i f : Fin n → ℂ) (a : Fin n) :
    weakValue i f (projMat a) = starRingEnd ℂ (f a) * i a / ip f i := by sorry

-- Generated from ChapterWeakValue.lean — theorem BookProof.ChapterWeakValue.ip_conj_mulVec
import Mathlib
import Definitions.Def_ChapterWeakValue
open BookProof.ChapterWeakValue

variable {n : ℕ}


open scoped BigOperators Matrix



theorem BookProof.ChapterWeakValue.ip_conj_mulVec (A : Matrix (Fin n) (Fin n) ℂ) (f v : Fin n → ℂ) :
    starRingEnd ℂ (ip f (A *ᵥ v)) = ip v (Aᴴ *ᵥ f) := by sorry

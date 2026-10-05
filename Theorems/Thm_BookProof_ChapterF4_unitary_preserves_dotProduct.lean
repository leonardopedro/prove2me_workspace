-- Generated from ChapterF4.lean — theorem BookProof.ChapterF4.unitary_preserves_dotProduct
import Mathlib
import Definitions.Def_ChapterF4
open BookProof.ChapterF4

variable {d k : ℕ}


open scoped BigOperators Matrix

theorem BookProof.ChapterF4.unitary_preserves_dotProduct {n : ℕ} (U : Matrix (Fin n) (Fin n) ℂ)
    (hU : Uᴴ * U = 1) (x y : Fin n → ℂ) :
    star (U.mulVec x) ⬝ᵥ U.mulVec y = star x ⬝ᵥ y := by sorry

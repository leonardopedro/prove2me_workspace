-- Generated from ChapterF4.lean — solution of BookProof.ChapterF4.unitary_preserves_dotProduct
import Mathlib
import Definitions.Def_ChapterF4
open BookProof.ChapterF4



open scoped BigOperators Matrix

variable {d k : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {n : ℕ} (U : Matrix (Fin n) (Fin n) ℂ)
    (hU : Uᴴ * U = 1) (x y : Fin n → ℂ) :
    star (U.mulVec x) ⬝ᵥ U.mulVec y = star x ⬝ᵥ y := by

  -- By the properties of the Hermitian transpose, we have:
  have h_star_mul : star (U *ᵥ x) = (star x) ᵥ* Uᴴ := by
    have h_conj : ∀ (v : Fin n → ℂ), star (U *ᵥ v) = (star v) ᵥ* Uᴴ := by
      intro v; ext i; simp [ Matrix.mulVec, dotProduct ] ;
      simp [ Matrix.vecMul, dotProduct, mul_comm ]
    exact h_conj x;
  simp_all ;
  simp [ Matrix.dotProduct_mulVec, hU ]

-- Generated from ChapterF4.lean — solution of BookProof.ChapterF4.pseudoinverse_left_inverse
import Mathlib
import Definitions.Def_ChapterF4
open BookProof.ChapterF4



open scoped BigOperators Matrix

variable {d k : ℕ}
variable {A : Type*} [NormedRing A] [NormedAlgebra ℂ A] [StarRing A] [ContinuousStar A]
  [CompleteSpace A] [StarModule ℂ A]

set_option maxHeartbeats 1000000 in
theorem solution {m n : ℕ} (Φ : Matrix (Fin m) (Fin n) ℂ)
    (h : IsUnit (Φᴴ * Φ).det) :
    ((Φᴴ * Φ)⁻¹ * Φᴴ) * Φ = 1 := by

  simp_all [ Matrix.mul_assoc ]

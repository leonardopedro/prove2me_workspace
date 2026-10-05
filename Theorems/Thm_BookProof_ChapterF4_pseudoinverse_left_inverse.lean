-- Generated from ChapterF4.lean — theorem BookProof.ChapterF4.pseudoinverse_left_inverse
import Mathlib
import Definitions.Def_ChapterF4
open BookProof.ChapterF4

variable {d k : ℕ}
variable {A : Type*} [NormedRing A] [NormedAlgebra ℂ A] [StarRing A] [ContinuousStar A]
  [CompleteSpace A] [StarModule ℂ A]


open scoped BigOperators Matrix

theorem BookProof.ChapterF4.pseudoinverse_left_inverse {m n : ℕ} (Φ : Matrix (Fin m) (Fin n) ℂ)
    (h : IsUnit (Φᴴ * Φ).det) :
    ((Φᴴ * Φ)⁻¹ * Φᴴ) * Φ = 1 := by sorry

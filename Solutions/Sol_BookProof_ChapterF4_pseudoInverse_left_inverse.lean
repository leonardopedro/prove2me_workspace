-- Generated from ChapterF4.lean — solution of BookProof.ChapterF4.pseudoInverse_left_inverse
import Mathlib
import Definitions.Def_ChapterF4
open BookProof.ChapterF4



open scoped BigOperators Matrix

variable {d k : ℕ}
variable {A : Type*} [NormedRing A] [NormedAlgebra ℂ A] [StarRing A] [ContinuousStar A]
  [CompleteSpace A] [StarModule ℂ A]
variable {α κ Ω : Type*} [Fintype α] [DecidableEq α] [Fintype κ] [DecidableEq κ]
  {mΩ : MeasurableSpace Ω}

set_option maxHeartbeats 1000000 in
theorem solution {k m : ℕ} (Φ : Matrix (Fin k) (Fin m) ℝ)
    [Invertible (Φᵀ * Φ)] :
    ⅟(Φᵀ * Φ) * Φᵀ * Φ = 1 := by

  simp [ Matrix.mul_assoc ]

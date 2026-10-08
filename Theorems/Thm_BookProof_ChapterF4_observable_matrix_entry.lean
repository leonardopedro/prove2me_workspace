-- Generated from ChapterF4.lean — theorem BookProof.ChapterF4.observable_matrix_entry
import Mathlib
import Definitions.Def_ChapterF4
open BookProof.ChapterF4


open scoped BigOperators Matrix

variable {d k : ℕ}
variable {A : Type*} [NormedRing A] [NormedAlgebra ℂ A] [StarRing A] [ContinuousStar A]
  [CompleteSpace A] [StarModule ℂ A]
variable {α κ Ω : Type*} [Fintype α] [DecidableEq α] [Fintype κ] [DecidableEq κ]
  {mΩ : MeasurableSpace Ω}

theorem BookProof.ChapterF4.observable_matrix_entry {d n : ℕ} (W : Matrix (Fin d) (Fin n) ℂ)
    (a : Fin d) (r s : Fin n) :
    Matrix.trace ((Matrix.single r s (1 : ℂ))ᴴ * Wᴴ * Matrix.single a a (1 : ℂ) * W)
      = (starRingEnd ℂ) (W a r) * W a s := by sorry

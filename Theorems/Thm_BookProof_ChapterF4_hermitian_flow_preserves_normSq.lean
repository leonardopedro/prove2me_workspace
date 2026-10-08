-- Generated from ChapterF4.lean — theorem BookProof.ChapterF4.hermitian_flow_preserves_normSq
import Mathlib
import Definitions.Def_ChapterF4
open BookProof.ChapterF4


open scoped BigOperators Matrix

variable {d k : ℕ}
variable {A : Type*} [NormedRing A] [NormedAlgebra ℂ A] [StarRing A] [ContinuousStar A]
  [CompleteSpace A] [StarModule ℂ A]
variable {α κ Ω : Type*} [Fintype α] [DecidableEq α] [Fintype κ] [DecidableEq κ]
  {mΩ : MeasurableSpace Ω}

theorem BookProof.ChapterF4.hermitian_flow_preserves_normSq {n : ℕ} (H : Matrix (Fin n) (Fin n) ℂ)
    (hH : H.IsHermitian) (t : ℝ) (c : Fin n → ℂ) :
    star ((NormedSpace.exp ((-Complex.I * (t : ℂ)) • H)).mulVec c)
          ⬝ᵥ (NormedSpace.exp ((-Complex.I * (t : ℂ)) • H)).mulVec c
      = star c ⬝ᵥ c := by sorry

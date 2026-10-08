-- Generated from ChapterF4.lean — theorem BookProof.ChapterF4.hermitian_flow_unitary
import Mathlib
import Definitions.Def_ChapterF4
open BookProof.ChapterF4


open scoped BigOperators Matrix

variable {d k : ℕ}
variable {A : Type*} [NormedRing A] [NormedAlgebra ℂ A] [StarRing A] [ContinuousStar A]
  [CompleteSpace A] [StarModule ℂ A]
variable {α κ Ω : Type*} [Fintype α] [DecidableEq α] [Fintype κ] [DecidableEq κ]
  {mΩ : MeasurableSpace Ω}

theorem BookProof.ChapterF4.hermitian_flow_unitary {n : ℕ} (H : Matrix (Fin n) (Fin n) ℂ)
    (hH : H.IsHermitian) (t : ℝ) :
    (NormedSpace.exp ((-Complex.I * (t : ℂ)) • H))ᴴ
        * NormedSpace.exp ((-Complex.I * (t : ℂ)) • H) = 1 := by sorry

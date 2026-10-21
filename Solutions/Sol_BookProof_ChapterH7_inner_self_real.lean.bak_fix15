-- Generated from ChapterH7.lean — solution of BookProof.ChapterH7.inner_self_real
import Mathlib
import Definitions.Def_ChapterH7
open BookProof.ChapterH7



noncomputable section

open BookProof.ChapterH4 BookProof.ChapterH6

variable {E F : Type*}
  [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
  [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (X : E →L[ℂ] E) (hX : IsSelfAdjoint X) (x : E) :
    (inner ℂ x (X x) : ℂ).im = 0 := by

  have hadj : ContinuousLinearMap.adjoint X = X :=
    (ContinuousLinearMap.star_eq_adjoint X).symm.trans hX
  have h : (starRingEnd ℂ) (inner ℂ x (X x) : ℂ) = (inner ℂ x (X x) : ℂ) := by
    rw [inner_conj_symm]
    calc (inner ℂ (X x) x : ℂ) = inner ℂ x ((ContinuousLinearMap.adjoint X) x) :=
          (ContinuousLinearMap.adjoint_inner_right X x x).symm
      _ = inner ℂ x (X x) := by rw [hadj]
  have := Complex.conj_eq_iff_im.mp h
  exact this

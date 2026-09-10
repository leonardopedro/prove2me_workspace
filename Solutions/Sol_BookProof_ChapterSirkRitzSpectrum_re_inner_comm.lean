-- Generated from ChapterSirkRitzSpectrum.lean — solution of BookProof.ChapterSirkRitzSpectrum.re_inner_comm
import Mathlib
import Definitions.Def_ChapterSirkRitzSpectrum
open BookProof.ChapterSirkRitzSpectrum








noncomputable section


open Filter Topology RCLike ContinuousLinearMap ComplexOrder Pointwise

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (T : F →L[ℂ] F) (x : F) :
    (inner ℂ (T x) x : ℂ).re = (inner ℂ x (T x) : ℂ).re := by

  have h : (starRingEnd ℂ) (inner ℂ x (T x)) = inner ℂ (T x) x := inner_conj_symm _ _
  rw [← h, Complex.conj_re]

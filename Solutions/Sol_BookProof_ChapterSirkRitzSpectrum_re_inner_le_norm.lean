-- Generated from ChapterSirkRitzSpectrum.lean — solution of BookProof.ChapterSirkRitzSpectrum.re_inner_le_norm
import Mathlib
import Definitions.Def_ChapterSirkRitzSpectrum
import Theorems.Thm_BookProof_ChapterSirkRitzSpectrum_abs_re_inner_le
open BookProof.ChapterSirkRitzSpectrum








noncomputable section


open Filter Topology RCLike ContinuousLinearMap ComplexOrder Pointwise

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (T : F →L[ℂ] F) (x : F) :
    (inner ℂ x (T x) : ℂ).re ≤ ‖T‖ * ‖x‖ ^ 2 := (le_abs_self _).trans (abs_re_inner_le T x)

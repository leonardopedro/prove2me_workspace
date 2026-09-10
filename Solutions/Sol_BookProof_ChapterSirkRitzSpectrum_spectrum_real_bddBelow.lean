-- Generated from ChapterSirkRitzSpectrum.lean — solution of BookProof.ChapterSirkRitzSpectrum.spectrum_real_bddBelow
import Mathlib
import Definitions.Def_ChapterSirkRitzSpectrum
import Theorems.Thm_BookProof_ChapterSirkRitzSpectrum_le_rayleigh_iff_le_spectrum
import Theorems.Thm_BookProof_ChapterSirkRitzSpectrum_neg_norm_le_re_inner
open BookProof.ChapterSirkRitzSpectrum








noncomputable section


open Filter Topology RCLike ContinuousLinearMap ComplexOrder Pointwise

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (T : F →L[ℂ] F) (hT : IsSelfAdjoint T) :
    BddBelow (spectrum ℝ T) := by

  refine ⟨-‖T‖, ?_⟩
  intro μ hμ
  refine (le_rayleigh_iff_le_spectrum T hT (-‖T‖)).mp ?_ μ hμ
  intro x
  have := neg_norm_le_re_inner T x
  linarith

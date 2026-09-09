-- Generated from ChapterSirkRitzPerturbation.lean — solution of BookProof.RitzPerturbation.minmaxGap_nonneg
import Mathlib
import Definitions.Def_ChapterSirkRitzPerturbation
open BookProof.RitzPerturbation









noncomputable section


open BookProof.RitzMinMax BookProof.ChapterSirkRitzSpectrum BookProof.HermiteGalerkin
open Filter Topology

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (T : F →L[ℂ] F) (hne1 : (minmaxSet T 1).Nonempty) :
    0 ≤ minmaxGap T := by

  have := minmaxLevel_mono T (Nat.zero_le 1) hne1
  simp only [minmaxGap]
  linarith

-- Generated from ChapterResolventMinMaxLadder.lean — solution of BookProof.ResolventLadder.sSup_rayleighSet_eq_sSup_spectrum
import Mathlib
import Definitions.Def_ChapterResolventMinMaxLadder
import Theorems.Thm_BookProof_ResolventLadder_rayleighSet_neg
import Theorems.Thm_BookProof_ChapterSirkRitzSpectrum_sInf_spectrum_eq_rayleighInf
open BookProof.ResolventLadder



noncomputable section


open BookProof.RitzMinMax BookProof.ChapterSirkRitzSpectrum BookProof.HermiteGalerkin
open BookProof.NonnegResolvent BookProof.PositiveSquareRoot
open BookProof.NonnegSquareRoot BookProof.ClosureUniqueness
open Filter Topology

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T : Submodule ℂ (F × F)}

set_option maxHeartbeats 1000000 in
theorem solution [Nontrivial F] (R : F →L[ℂ] F)
    (hR : IsSelfAdjoint R) : sSup (rayleighSet R) = sSup (spectrum ℝ R) := by

  have h := sInf_spectrum_eq_rayleighInf (-R) hR.neg
  rw [← spectrum.neg_eq, rayleighInf, rayleighSet_neg, Real.sInf_neg, Real.sInf_neg] at h
  linarith

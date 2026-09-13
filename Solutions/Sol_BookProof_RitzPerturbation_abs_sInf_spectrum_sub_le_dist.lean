-- Generated from ChapterSirkRitzPerturbation.lean — solution of BookProof.RitzPerturbation.abs_sInf_spectrum_sub_le_dist
import Mathlib
import Definitions.Def_ChapterSirkRitzPerturbation
import Theorems.Thm_BookProof_RitzPerturbation_abs_minmaxLevel_sub_le_dist
import Theorems.Thm_BookProof_RitzMinMax_minmaxLevel_zero_eq_sInf_spectrum
import Definitions.Def_ChapterSirkRitzSpectrum
import Definitions.Def_ChapterSirkRitzMinMax
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
open BookProof.RitzPerturbation









noncomputable section


open BookProof.RitzMinMax BookProof.ChapterSirkRitzSpectrum BookProof.HermiteGalerkin
open Filter Topology

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution [Nontrivial F] (T T' : F →L[ℂ] F)
    (hT : IsSelfAdjoint T) (hT' : IsSelfAdjoint T')
    (hne : (minmaxSet T 0).Nonempty) :
    |sInf (spectrum ℝ T) - sInf (spectrum ℝ T')| ≤ ‖T - T'‖ := by

  rw [← minmaxLevel_zero_eq_sInf_spectrum T hT, ← minmaxLevel_zero_eq_sInf_spectrum T' hT']
  exact abs_minmaxLevel_sub_le_dist T T' 0 hne

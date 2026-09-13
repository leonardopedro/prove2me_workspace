-- Generated from ChapterSirkRitzMinMax.lean — solution of BookProof.RitzMinMax.minmaxLevel_zero_eq_sInf_spectrum
import Mathlib
import Definitions.Def_ChapterSirkRitzMinMax
import Theorems.Thm_BookProof_RitzMinMax_minmaxLevel_zero_eq_rayleighInf
import Theorems.Thm_BookProof_ChapterSirkRitzSpectrum_sInf_spectrum_eq_rayleighInf
import Definitions.Def_ChapterSirkRitzSpectrum
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
open BookProof.RitzMinMax










noncomputable section


open BookProof.HermiteGalerkin BookProof.ChapterSirkRitzSpectrum
open Filter Topology

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution [Nontrivial F] (T : F →L[ℂ] F)
    (hT : IsSelfAdjoint T) : minmaxLevel T 0 = sInf (spectrum ℝ T) := by

  rw [minmaxLevel_zero_eq_rayleighInf T, ← sInf_spectrum_eq_rayleighInf T hT]

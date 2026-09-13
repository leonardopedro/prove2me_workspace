-- Generated from ChapterSirkRitzMinMax.lean — solution of BookProof.RitzMinMax.neg_norm_le_rayleighVal_of_unit
import Mathlib
import Definitions.Def_ChapterSirkRitzMinMax
import Theorems.Thm_BookProof_RitzMinMax_abs_rayleighVal_le
import Definitions.Def_ChapterSirkRitzSpectrum
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
open BookProof.RitzMinMax










noncomputable section


open BookProof.HermiteGalerkin BookProof.ChapterSirkRitzSpectrum
open Filter Topology

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (T : F →L[ℂ] F) {x : F} (hx1 : ‖x‖ = 1) :
    -‖T‖ ≤ rayleighVal T x := by

  have h := neg_le_of_abs_le (abs_rayleighVal_le T x)
  rwa [hx1, one_pow, mul_one] at h

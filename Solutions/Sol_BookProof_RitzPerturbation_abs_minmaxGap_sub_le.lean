-- Generated from ChapterSirkRitzPerturbation.lean — solution of BookProof.RitzPerturbation.abs_minmaxGap_sub_le
import Mathlib
import Definitions.Def_ChapterSirkRitzPerturbation
import Theorems.Thm_BookProof_RitzPerturbation_abs_minmaxLevel_sub_le_dist
import Definitions.Def_ChapterSirkRitzSpectrum
import Definitions.Def_ChapterSirkRitzMinMax
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
open BookProof.RitzPerturbation









noncomputable section


open BookProof.RitzMinMax BookProof.ChapterSirkRitzSpectrum BookProof.HermiteGalerkin
open Filter Topology

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (T T' : F →L[ℂ] F)
    (hne0 : (minmaxSet T 0).Nonempty) (hne1 : (minmaxSet T 1).Nonempty) :
    |minmaxGap T - minmaxGap T'| ≤ 2 * ‖T - T'‖ := by

  have h0 := abs_minmaxLevel_sub_le_dist T T' 0 hne0
  have h1 := abs_minmaxLevel_sub_le_dist T T' 1 hne1
  rw [abs_sub_le_iff] at h0 h1 ⊢
  constructor <;> simp only [minmaxGap] <;> linarith [h0.1, h0.2, h1.1, h1.2]

-- Generated from ChapterSirkRitzPerturbation.lean — solution of BookProof.RitzPerturbation.abs_minmaxLevelIn_sub_le_dist
import Mathlib
import Definitions.Def_ChapterSirkRitzPerturbation
import Theorems.Thm_BookProof_RitzPerturbation_minmaxSetIn_nonempty_congr
import Theorems.Thm_BookProof_RitzPerturbation_minmaxLevelIn_le_minmaxLevelIn_add
import Definitions.Def_ChapterSirkRitzSpectrum
import Definitions.Def_ChapterSirkRitzMinMax
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
open BookProof.RitzPerturbation









noncomputable section


open BookProof.RitzMinMax BookProof.ChapterSirkRitzSpectrum BookProof.HermiteGalerkin
open Filter Topology

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (T T' : F →L[ℂ] F) (W : Submodule ℂ F) (k : ℕ)
    (hne : (minmaxSetIn T W k).Nonempty) :
    |minmaxLevelIn T W k - minmaxLevelIn T' W k| ≤ ‖T - T'‖ := by

  have hne' : (minmaxSetIn T' W k).Nonempty := minmaxSetIn_nonempty_congr T T' hne
  refine abs_sub_le_iff.mpr ⟨by linarith [minmaxLevelIn_le_minmaxLevelIn_add T T' W k hne'], ?_⟩
  have h := minmaxLevelIn_le_minmaxLevelIn_add T' T W k hne
  rw [← neg_sub T T', norm_neg] at h
  linarith

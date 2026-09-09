-- Generated from ChapterSirkRitzPerturbation.lean — solution of BookProof.RitzPerturbation.abs_minmaxLevel_sub_le_dist
import Mathlib
import Definitions.Def_ChapterSirkRitzPerturbation
import Theorems.Thm_BookProof_RitzPerturbation_minmaxSet_nonempty_congr
import Theorems.Thm_BookProof_RitzPerturbation_minmaxLevel_le_minmaxLevel_add
open BookProof.RitzPerturbation









noncomputable section


open BookProof.RitzMinMax BookProof.ChapterSirkRitzSpectrum BookProof.HermiteGalerkin
open Filter Topology

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (T T' : F →L[ℂ] F) (k : ℕ)
    (hne : (minmaxSet T k).Nonempty) :
    |minmaxLevel T k - minmaxLevel T' k| ≤ ‖T - T'‖ := by

  have hne' : (minmaxSet T' k).Nonempty := minmaxSet_nonempty_congr T T' hne
  refine abs_sub_le_iff.mpr ⟨by linarith [minmaxLevel_le_minmaxLevel_add T T' k hne'], ?_⟩
  have h := minmaxLevel_le_minmaxLevel_add T' T k hne
  rw [← neg_sub T T', norm_neg] at h
  linarith

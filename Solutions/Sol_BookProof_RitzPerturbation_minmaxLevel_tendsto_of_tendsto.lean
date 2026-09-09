-- Generated from ChapterSirkRitzPerturbation.lean — solution of BookProof.RitzPerturbation.minmaxLevel_tendsto_of_tendsto
import Mathlib
import Definitions.Def_ChapterSirkRitzPerturbation
import Theorems.Thm_BookProof_RitzPerturbation_minmaxSet_nonempty_congr
import Theorems.Thm_BookProof_RitzPerturbation_abs_minmaxLevel_sub_le_dist
open BookProof.RitzPerturbation









noncomputable section


open BookProof.RitzMinMax BookProof.ChapterSirkRitzSpectrum BookProof.HermiteGalerkin
open Filter Topology

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution {ι : Type*} {l : Filter ι} (Tn : ι → F →L[ℂ] F)
    (T : F →L[ℂ] F) (k : ℕ) (hne : (minmaxSet T k).Nonempty)
    (h : Tendsto (fun i => ‖Tn i - T‖) l (𝓝 0)) :
    Tendsto (fun i => minmaxLevel (Tn i) k) l (𝓝 (minmaxLevel T k)) := by

  rw [tendsto_iff_dist_tendsto_zero]
  refine squeeze_zero (fun i => dist_nonneg) (fun i => ?_) h
  rw [Real.dist_eq]
  exact abs_minmaxLevel_sub_le_dist (Tn i) T k (minmaxSet_nonempty_congr T _ hne)

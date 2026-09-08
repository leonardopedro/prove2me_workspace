-- Generated from ChapterBaryonAsymmetry.lean — solution of BookProof.ChapterBaryonAsymmetry.matterRadiationRatio_strictMonoOn
import Mathlib
import Definitions.Def_ChapterBaryonAsymmetry
import Theorems.Thm_BookProof_ChapterBaryonAsymmetry_matterRadiationRatio_eq
open BookProof.ChapterBaryonAsymmetry













open Filter Topology

set_option maxHeartbeats 1000000 in
theorem solution (ρm0 ρr0 : ℝ) (hm : 0 < ρm0) (hr : 0 < ρr0) :
    StrictMonoOn (fun a => matterRadiationRatio ρm0 ρr0 a) (Set.Ioi (0 : ℝ)) := by

  have hk : 0 < ρm0 / ρr0 := div_pos hm hr
  intro x hx y hy hxy
  dsimp only
  rw [matterRadiationRatio_eq _ _ _ hx (ne_of_gt hr),
    matterRadiationRatio_eq _ _ _ hy (ne_of_gt hr)]
  exact mul_lt_mul_of_pos_left hxy hk

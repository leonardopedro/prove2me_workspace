-- Generated from ChapterGravitySplit.lean — solution of BookProof.ChapterGravitySplit.timePart_eq_smul
import Mathlib
import Definitions.Def_ChapterGravitySplit
open BookProof.ChapterGravitySplit




open Matrix
open scoped BigOperators
open BookProof.ChapterGravityProjector
open BookProof.ChapterGravityTimeProj

set_option maxHeartbeats 1000000 in
theorem solution (v x : Fin 4 → ℝ) :
    timePart v x = (-(minkForm x v)) • v := by

  ext a;
  unfold timePart minkForm; simp only [mulVec, dotProduct, Fin.sum_univ_four, Fin.isValue,
      neg_add_rev, Pi.smul_apply, smul_eq_mul] ; ring;
  unfold timeProj; norm_num; ring;

-- Generated from ChapterGravityTimeProj.lean — solution of BookProof.ChapterGravityTimeProj.timeProj_idempotent
import Mathlib
import Definitions.Def_ChapterGravityTimeProj
open BookProof.ChapterGravityTimeProj




open Matrix
open scoped BigOperators
open BookProof.ChapterGravityProjector

set_option maxHeartbeats 1000000 in
theorem solution (v : Fin 4 → ℝ) (hv : minkSq v = -1) :
    timeProj v * timeProj v = timeProj v := by

  unfold timeProj;
  ext a b; simp only [mul_apply, of_apply, mul_neg, neg_mul, neg_neg, Fin.sum_univ_four,
      Fin.isValue] ; ring;
  unfold minkSq at hv; simp_all only [lower, Fin.sum_univ_four, Fin.isValue] ;
  linear_combination' hv * v a * ( metric *ᵥ v ) b

-- Generated from ChapterGravityProjector.lean — solution of BookProof.ChapterGravityProjector.spatialProj_mulVec_self
import Mathlib
import Definitions.Def_ChapterGravityProjector
open BookProof.ChapterGravityProjector




open Matrix
open scoped BigOperators

set_option maxHeartbeats 1000000 in
theorem solution (v : Fin 4 → ℝ) (hv : minkSq v = -1) :
    (spatialProj v).mulVec v = 0 := by

  ext a;
  simp only [mulVec, dotProduct, spatialProj, Matrix.add_apply, Matrix.of_apply, Pi.zero_apply];
  simp_all only [minkSq, lower, add_mul, mul_assoc, Finset.sum_add_distrib];
  simp_all only [Matrix.one_apply, mul_comm, mul_ite, mul_one, mul_zero, Finset.sum_ite_eq,
      Finset.mem_univ, ↓reduceIte];
  rw [← Finset.mul_sum, hv]; ring

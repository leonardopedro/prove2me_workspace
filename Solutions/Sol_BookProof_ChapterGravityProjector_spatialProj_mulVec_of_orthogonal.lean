-- Generated from ChapterGravityProjector.lean — solution of BookProof.ChapterGravityProjector.spatialProj_mulVec_of_orthogonal
import Mathlib
import Definitions.Def_ChapterGravityProjector
open BookProof.ChapterGravityProjector




open Matrix
open scoped BigOperators

set_option maxHeartbeats 1000000 in
theorem solution (v x : Fin 4 → ℝ)
    (hx : ∑ a, lower v a * x a = 0) :
    (spatialProj v).mulVec x = x := by

  simp_all [ spatialProj, Matrix.mulVec, funext_iff ];
  simp_all [ Matrix.one_apply, dotProduct ];
  simp_all [ Finset.sum_add_distrib, add_mul ];
  simp_all [ mul_assoc, ← Finset.mul_sum _ _ _ ]

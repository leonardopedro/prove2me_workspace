-- Generated from ChapterGravitySplit.lean — solution of BookProof.ChapterGravitySplit.split_unique
import Mathlib
import Definitions.Def_ChapterGravitySplit
open BookProof.ChapterGravitySplit




open Matrix
open scoped BigOperators
open BookProof.ChapterGravityProjector
open BookProof.ChapterGravityTimeProj

set_option maxHeartbeats 1000000 in
theorem solution (v x s : Fin 4 → ℝ) (c : ℝ) (hv : minkSq v = -1)
    (hs : minkForm s v = 0) (hx : x = s + c • v) :
    s = spatialPart v x ∧ c • v = timePart v x := by

  unfold spatialPart timePart;
  simp_all [ spatialProj, timeProj, Matrix.mulVec_add, Matrix.mulVec_smul ];
  simp_all [ Matrix.add_mulVec, minkForm ];
  simp_all [ funext_iff, Matrix.mulVec, dotProduct ];
  simp_all [ mul_comm, mul_left_comm, Finset.mul_sum _ _ _, minkSq ];
  simp_all [ ← Finset.mul_sum _ _ _ ]

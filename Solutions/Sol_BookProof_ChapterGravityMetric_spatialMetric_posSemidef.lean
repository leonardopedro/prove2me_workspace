-- Generated from ChapterGravityMetric.lean — solution of BookProof.ChapterGravityMetric.spatialMetric_posSemidef
import Mathlib
import Definitions.Def_ChapterGravityMetric
import Theorems.Thm_BookProof_ChapterGravityMetric_spatialMetric_quadForm_nonneg
open BookProof.ChapterGravityMetric




open Matrix
open scoped BigOperators
open BookProof.ChapterGravityProjector

set_option maxHeartbeats 1000000 in
theorem solution (v : Fin 4 → ℝ) (hv : minkSq v = -1) :
    (spatialMetric v).PosSemidef := by

      constructor;
      · ext i j; simp only [spatialMetric, conjTranspose_apply, Matrix.add_apply, of_apply, star_trivial] ;
        unfold metric; fin_cases i <;> fin_cases j <;> simp [ mul_comm ] ;
      · intro x;
        convert spatialMetric_quadForm_nonneg v ( fun i => x i ) hv using 1
        · rfl
        · simp [ Finsupp.sum_fintype, dotProduct, Matrix.mulVec, Finset.mul_sum _ _ _, mul_comm,
            mul_left_comm ]

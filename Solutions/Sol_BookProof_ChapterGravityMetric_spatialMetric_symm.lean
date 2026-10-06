-- Generated from ChapterGravityMetric.lean — solution of BookProof.ChapterGravityMetric.spatialMetric_symm
import Mathlib
import Definitions.Def_ChapterGravityMetric
open BookProof.ChapterGravityMetric




open Matrix
open scoped BigOperators
open BookProof.ChapterGravityProjector

set_option maxHeartbeats 1000000 in
theorem solution (v : Fin 4 → ℝ) :
    (spatialMetric v)ᵀ = spatialMetric v := by

      unfold spatialMetric; ext i j; simp only [lower, transpose_apply, Matrix.add_apply, of_apply,
          mul_comm, add_left_inj] ;
      unfold metric; fin_cases i <;> fin_cases j <;> rfl;

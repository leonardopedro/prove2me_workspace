-- Generated from ChapterGravityInvMetric.lean — solution of BookProof.ChapterGravityInvMetric.invSpatialMetric_symm
import Mathlib
import Definitions.Def_ChapterGravityInvMetric
open BookProof.ChapterGravityInvMetric




open Matrix
open scoped BigOperators
open BookProof.ChapterGravityProjector
open BookProof.ChapterGravityMetric

set_option maxHeartbeats 1000000 in
theorem solution (v : Fin 4 → ℝ) :
    (invSpatialMetric v)ᵀ = invSpatialMetric v := by

      ext i j; simp only [invSpatialMetric, transpose_apply, Matrix.add_apply, of_apply,
          mul_comm, add_left_inj]
      fin_cases i <;> fin_cases j <;> rfl

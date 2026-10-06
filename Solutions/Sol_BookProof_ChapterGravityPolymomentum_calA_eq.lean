-- Generated from ChapterGravityPolymomentum.lean — solution of BookProof.ChapterGravityPolymomentum.calA_eq
import Mathlib
import Definitions.Def_ChapterGravityPolymomentum
import Theorems.Thm_BookProof_ChapterGravityPolymomentum_metric_transpose
import Theorems.Thm_BookProof_ChapterGravityPolymomentum_proj_sub
import Theorems.Thm_BookProof_ChapterGravityPolymomentum_proj_transpose
import Theorems.Thm_BookProof_ChapterGravityPolymomentum_vecMulVec_self_transpose
import Theorems.Thm_BookProof_ChapterGravityPolymomentum_proj_polyMom
open BookProof.ChapterGravityPolymomentum




open Matrix
open scoped BigOperators
open BookProof.ChapterGravityProjector

variable {e T : ℝ} {S Tc : Matrix (Fin 4) (Fin 4) ℝ} {u v : Fin 4 → ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (hv : minkSq v = -1) (hS : IsSpatial v S) (hTc : IsSpatial v Tc)
    (hSsymm : Sᵀ = S) (hTcanti : Tcᵀ = -Tc) :
    calA v (polyMom e T S Tc u v) = (-2 * e) • Tc := by

  have hp := proj_polyMom (e := e) (T := T) (u := u) hv hS hTc
  have hAt : (proj v (polyMom e T S Tc u v))ᵀ
      = e • (S - ((4 / 3) * T) • (metric + vecMulVec v v) + Tc) := by
    rw [hp]
    simp only [Matrix.transpose_smul, Matrix.transpose_sub, Matrix.transpose_add, hSsymm,
      metric_transpose, vecMulVec_self_transpose, hTcanti]
    module
  rw [calA, proj_sub, proj_transpose, hAt, hp]
  module

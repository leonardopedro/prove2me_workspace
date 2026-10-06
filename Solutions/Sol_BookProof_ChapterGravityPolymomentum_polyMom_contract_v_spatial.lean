-- Generated from ChapterGravityPolymomentum.lean — solution of BookProof.ChapterGravityPolymomentum.polyMom_contract_v_spatial
import Mathlib
import Definitions.Def_ChapterGravityPolymomentum
import Theorems.Thm_BookProof_ChapterGravityPolymomentum_polyMom_contract_v
open BookProof.ChapterGravityPolymomentum




open Matrix
open scoped BigOperators
open BookProof.ChapterGravityProjector

variable {e T : ℝ} {S Tc : Matrix (Fin 4) (Fin 4) ℝ} {u v : Fin 4 → ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (hv : minkSq v = -1) (hS : IsSpatial v S)
    (hTc : IsSpatial v Tc) :
    (spatialProj v).mulVec ((polyMom e T S Tc u v).mulVec (lower v))
      = (-2 * e) • (spatialProj v).mulVec u := by

  have hXv : (spatialProj v).mulVec v = 0 := spatialProj_mulVec_self v hv
  rw [polyMom_contract_v hv hS hTc, Matrix.mulVec_smul, Matrix.mulVec_add,
    Matrix.mulVec_smul, Matrix.mulVec_smul, hXv]
  module

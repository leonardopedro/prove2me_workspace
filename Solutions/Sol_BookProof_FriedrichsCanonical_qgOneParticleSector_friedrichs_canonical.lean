-- Generated from ChapterFriedrichsCanonical.lean — solution of BookProof.FriedrichsCanonical.qgOneParticleSector_friedrichs_canonical
import Mathlib
import Definitions.Def_ChapterFriedrichsCanonical
import Theorems.Thm_BookProof_FriedrichsCanonical_semiboundedFriedrichsOp_isSemiboundedSelfAdjointExtension
import Theorems.Thm_BookProof_QgHermiteCore_continuous_scalaronSectorPotential
import Theorems.Thm_BookProof_QgHermiteCore_expBounded_scalaronSectorPotential
import Theorems.Thm_BookProof_QgHermiteFriedrichs_hamCore_quadForm_ge
import Theorems.Thm_BookProof_QgHermiteFriedrichs_hamCore_symmetricOn
open BookProof.FriedrichsCanonical




open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.HashimotoShiftInvert
open BookProof.FriedrichsExtension BookProof.FriedrichsExtension.FormDom

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {D : Submodule ℂ F}

set_option maxHeartbeats 1000000 in
theorem solution (M alpha : ℝ) (hM : 0 < M) (halpha : 0 < alpha)
    (V3 : Polynomial ℝ) (c : ℝ) (hV3 : ∀ t : ℝ, -c ≤ V3.eval t) :
    IsSemiboundedSelfAdjointExtension c
      (hamCore (scalaronSectorPotential M alpha V3)
        (continuous_scalaronSectorPotential M alpha V3)
        (expBounded_scalaronSectorPotential M alpha hM V3))
      (qgSectorFriedrichsOp M alpha hM halpha V3 c hV3) :=
  semiboundedFriedrichsOp_isSemiboundedSelfAdjointExtension _ (hamCore_symmetricOn _ _ _) c
      (hamCore_quadForm_ge _ _ _ c (scalaronSectorPotential_lower M alpha halpha V3 c hV3))
      polyGaussCore_dense

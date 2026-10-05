-- Generated from ChapterYangMillsFockFriedrichs.lean — solution of BookProof.YmFockFriedrichs.ymFock_friedrichs_extension
import Mathlib
import Definitions.Def_ChapterYangMillsFockFriedrichs
import Theorems.Thm_BookProof_YmFockFriedrichs_ymFockCore_dense
import Theorems.Thm_BookProof_YmFockFriedrichs_ymFockHam_symmetricOn
import Theorems.Thm_BookProof_YmFockFriedrichs_ymFockHam_quadForm_nonneg
import Theorems.Thm_BookProof_FriedrichsExtension_friedrichs_extension_exists
open BookProof.YmFockFriedrichs




open MvPolynomial
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.FriedrichsExtension
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.QgOuterFock BookProof.StoneBridge BookProof.Qg3DGaugeFL
open BookProof.ChapterStoneResolvent

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (fabc : Fin 8 → Fin 8 → Fin 8 → ℝ) :
    ∃ (Dom : Submodule ℂ ymFockSpace) (A : Dom →ₗ[ℂ] ymFockSpace),
      IsPositiveSelfAdjointExtension (ymFockHam fabc) A :=
  friedrichs_extension_exists
      ⟨ymFockCore, ymFockHam fabc, ymFockHam_symmetricOn fabc, ymFockHam_quadForm_nonneg fabc⟩
      ymFockCore_dense

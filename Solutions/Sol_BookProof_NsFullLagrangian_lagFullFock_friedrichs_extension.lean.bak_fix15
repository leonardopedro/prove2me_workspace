-- Generated from ChapterNavierStokesFullLagrangianFock.lean — solution of BookProof.NsFullLagrangian.lagFullFock_friedrichs_extension
import Mathlib
import Definitions.Def_ChapterNavierStokesFullLagrangianFock
import Theorems.Thm_BookProof_NsFullLagrangian_lagFockCore_dense
import Theorems.Thm_BookProof_NsFullLagrangian_lagFullFockHam_symmetricOn
import Theorems.Thm_BookProof_NsFullLagrangian_lagFullFockHam_quadForm_nonneg
import Theorems.Thm_BookProof_FriedrichsExtension_friedrichs_extension_exists
open BookProof.NsFullLagrangian




open MvPolynomial
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.FriedrichsExtension
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.QgOuterFock BookProof.StoneBridge BookProof.QgOuterFockFL
open BookProof.QgOuterFockInteractionFL BookProof.Qg3DGaugeFL
open BookProof.ChapterStoneResolvent

noncomputable section

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (lam lam' mu gg : ℝ) :
    ∃ (Dom : Submodule ℂ lagFockSpace) (A : Dom →ₗ[ℂ] lagFockSpace),
      IsPositiveSelfAdjointExtension (lagFullFockHam lam lam' mu gg) A :=
  friedrichs_extension_exists
      ⟨lagFockCore, lagFullFockHam lam lam' mu gg, lagFullFockHam_symmetricOn lam lam' mu gg,
        lagFullFockHam_quadForm_nonneg lam lam' mu gg⟩
      lagFockCore_dense

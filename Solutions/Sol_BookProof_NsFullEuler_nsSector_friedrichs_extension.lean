-- Generated from ChapterNavierStokesFullEulerianFock.lean — solution of BookProof.NsFullEuler.nsSector_friedrichs_extension
import Mathlib
import Definitions.Def_ChapterNavierStokesFullEulerianFock
import Theorems.Thm_BookProof_FriedrichsExtension_friedrichs_extension_exists
open BookProof.NsFullEuler




open MvPolynomial
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.FriedrichsExtension
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.QgOuterFock BookProof.StoneBridge BookProof.QgOuterFockFL
open BookProof.QgOuterFockInteractionFL BookProof.Qg3DGaugeFL
open BookProof.ChapterStoneResolvent

noncomputable section

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (nu lam mu gg : ℝ) (n : ℕ) :
    ∃ (Dom : Submodule ℂ (L2d (n * 21))) (A : Dom →ₗ[ℂ] L2d (n * 21)),
      IsPositiveSelfAdjointExtension (nsSectorHam nu lam mu gg n) A :=
  friedrichs_extension_exists
      ⟨polyGaussCore, nsSectorHam nu lam mu gg n, nsSectorHam_symmetricOn nu lam mu gg n,
        nsSectorHam_quadForm_nonneg nu lam mu gg n⟩
      polyGaussCore_dense

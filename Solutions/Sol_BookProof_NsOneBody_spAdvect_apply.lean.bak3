-- Generated from ChapterNsOneBodyDGamma.lean — solution of BookProof.NsOneBody.spAdvect_apply
import Mathlib
import Definitions.Def_ChapterNsOneBodyDGamma
import Theorems.Thm_BookProof_YangMillsFriedrichs_weylOp_apply
open BookProof.NsOneBody




open MvPolynomial
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.FriedrichsExtension
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.QgOuterFockFL
open BookProof.NsFullEuler BookProof.FockSecondQuantization BookProof.FockSchur
open BookProof.HermiteGalerkin BookProof.NavierStokesFlow BookProof.StoneBridge
open BookProof.ChapterStoneResolvent BookProof.EsaClosure

noncomputable section

variable {D : Submodule ℂ (L2d 6)}

set_option maxHeartbeats 1000000 in
theorem solution (Φ : CoreRep 6 D) (nu : ℝ) (k : Fin 3 → ℝ) (x : D) :
    spAdvect Φ nu k x
      = ((1 / 2 : ℝ) : ℂ)
        • ((∑ _i : Fin 0, ((0 : D →ₗ[ℂ] D) ((0 : D →ₗ[ℂ] D) x) : D) : L2d 6)
            + ∑ r, ((spFieldAdv Φ nu k r (spFieldAdv Φ nu k r x) : D) : L2d 6)) := weylOp_apply _ _ x

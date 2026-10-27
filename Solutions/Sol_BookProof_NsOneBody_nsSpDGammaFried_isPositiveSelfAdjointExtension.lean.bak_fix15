-- Generated from ChapterNsOneBodyDGamma.lean — solution of BookProof.NsOneBody.nsSpDGammaFried_isPositiveSelfAdjointExtension
import Mathlib
import Definitions.Def_ChapterNsOneBodyDGamma
import Theorems.Thm_BookProof_NsOneBody_lpFiniteModes_le_nsSpDGammaFriedDom
import Theorems.Thm_BookProof_NsOneBody_nsSpDGammaFried_op_core
import Theorems.Thm_BookProof_QgOuterFockFL_Comparison_isPositiveSelfAdjointExtension
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
theorem solution (e : ℕ ≃ (Fin 6 →₀ ℕ)) (nu : ℝ)
    (k : Fin 3 → ℝ) :
    IsPositiveSelfAdjointExtension (dGammaOp (nsSpCol e nu k)) (nsSpDGammaFried e nu k).op :=
  (nsSpDGammaFried e nu k).isPositiveSelfAdjointExtension (dGammaOp (nsSpCol e nu k))
      (fun x => ⟨lpFiniteModes_le_nsSpDGammaFriedDom e nu k x.2,
        nsSpDGammaFried_op_core e nu k x _⟩)

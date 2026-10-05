-- Generated from ChapterNsOneBodyDGamma.lean — solution of BookProof.NsOneBody.lpFiniteModes_le_nsSpDGammaFriedDom
import Mathlib
import Definitions.Def_ChapterNsOneBodyDGamma
import Theorems.Thm_BookProof_QgOuterFockFL_friedrichsComparison_extends
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
theorem solution (e : ℕ ≃ (Fin 6 →₀ ℕ)) (nu : ℝ) (k : Fin 3 → ℝ) :
    (lpFiniteModes Conf) ≤ (nsSpDGammaFried e nu k).dom :=
  fun v hv =>
    (friedrichsComparison_extends (nsSpDGammaPosSym e nu k) finiteOccupation_dense
      ⟨v, hv⟩).choose

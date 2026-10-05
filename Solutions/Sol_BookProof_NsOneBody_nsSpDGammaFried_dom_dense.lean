-- Generated from ChapterNsOneBodyDGamma.lean — solution of BookProof.NsOneBody.nsSpDGammaFried_dom_dense
import Mathlib
import Definitions.Def_ChapterNsOneBodyDGamma
import Theorems.Thm_BookProof_NsOneBody_lpFiniteModes_le_nsSpDGammaFriedDom
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
    Dense (((nsSpDGammaFried e nu k).dom : Submodule ℂ Fock) : Set Fock) :=
  finiteOccupation_dense.mono
      (SetLike.coe_subset_coe.mpr (lpFiniteModes_le_nsSpDGammaFriedDom e nu k))

-- Generated from ChapterNsOneBodyDGamma.lean — solution of BookProof.NsOneBody.spFried_dom_dense
import Mathlib
import Definitions.Def_ChapterNsOneBodyDGamma
import Theorems.Thm_BookProof_NsOneBody_polyGaussCore_le_spFriedDom
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
theorem solution (nu : ℝ) (k : Fin 3 → ℝ) :
    Dense (((spFried nu k).dom : Submodule ℂ (L2d 6)) : Set (L2d 6)) := polyGaussCore_dense.mono (SetLike.coe_subset_coe.mpr (polyGaussCore_le_spFriedDom nu k))

-- Generated from ChapterNsOneBodyDGamma.lean — solution of BookProof.NsOneBody.spHamDom_eq_visc_add_advect
import Mathlib
import Definitions.Def_ChapterNsOneBodyDGamma
import Theorems.Thm_BookProof_NsOneBody_spField_sq_split
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterQgOuterFockFarisLavine
import Definitions.Def_ChapterNavierStokesFullEulerianFock
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterFockSchurEsa
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterYangMillsHermite
open BookProof.NsOneBody




open MvPolynomial
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.FriedrichsExtension
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.QgOuterFockFL
open BookProof.NsFullEuler BookProof.FockSecondQuantization BookProof.FockSchur
open BookProof.HermiteGalerkin BookProof.NavierStokesFlow BookProof.StoneBridge
open BookProof.ChapterStoneResolvent BookProof.EsaClosure
open BookProof.HermiteProductCore
open BookProof.YangMillsFriedrichs
open BookProof.YangMillsHermite

noncomputable section

variable {D : Submodule ℂ (L2d 6)}

set_option maxHeartbeats 1000000 in
theorem solution (Φ : CoreRep 6 D) (nu : ℝ) (k : Fin 3 → ℝ) :
    weylOpDom (spPi Φ) (spField Φ nu k)
      = weylOpDom (spPi Φ) (spFieldVisc Φ nu k)
        + weylOpDom (fun _ : Fin 0 => (0 : D →ₗ[ℂ] D)) (spFieldAdv Φ nu k) := by

  have hsum : (∑ r, (spField Φ nu k r).comp (spField Φ nu k r))
      = (∑ r, (spFieldVisc Φ nu k r).comp (spFieldVisc Φ nu k r))
        + ∑ r, (spFieldAdv Φ nu k r).comp (spFieldAdv Φ nu k r) := by
    rw [← Finset.sum_add_distrib]
    exact Finset.sum_congr rfl fun r _ => spField_sq_split Φ nu k r
  simp only [weylOpDom, hsum]
  simp only [Finset.univ_eq_empty, Finset.sum_empty]
  module

-- Generated from ChapterNsOneBodyDGamma.lean — theorem BookProof.NsOneBody.spHamDom_eq_visc_add_advect
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
import Mathlib
import Definitions.Def_ChapterNsOneBodyDGamma
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterYangMillsHermite
open BookProof.HermiteProductCore
open BookProof.YangMillsFriedrichs
open BookProof.YangMillsHermite
open BookProof.NsOneBody

variable {D : Submodule ℂ (L2d 6)}



open MvPolynomial
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.FriedrichsExtension
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.QgOuterFockFL
open BookProof.NsFullEuler BookProof.FockSecondQuantization BookProof.FockSchur
open BookProof.HermiteGalerkin BookProof.NavierStokesFlow BookProof.StoneBridge
open BookProof.ChapterStoneResolvent BookProof.EsaClosure

noncomputable section

theorem BookProof.NsOneBody.spHamDom_eq_visc_add_advect (Φ : CoreRep 6 D) (nu : ℝ) (k : Fin 3 → ℝ) :
    weylOpDom (spPi Φ) (spField Φ nu k)
      = weylOpDom (spPi Φ) (spFieldVisc Φ nu k)
        + weylOpDom (fun _ : Fin 0 => (0 : D →ₗ[ℂ] D)) (spFieldAdv Φ nu k) := by sorry

-- Generated from ChapterNsOneBodyDGamma.lean — solution of BookProof.NsOneBody.nsSpDGamma_stone_flow
import Mathlib
import Definitions.Def_ChapterNsOneBodyDGamma
import Theorems.Thm_BookProof_NsOneBody_nsSpDGamma_esa_farisLavine
import Theorems.Thm_BookProof_NsOneBody_nsSpDGammaFried_dom_dense
import Theorems.Thm_BookProof_StoneBridge_exists_stone_flow_of_esa
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterQgOuterFockFarisLavine
import Definitions.Def_ChapterNavierStokesFullEulerianFock
import Definitions.Def_ChapterFockSchurEsa
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterStoneResolvent
open BookProof.NsOneBody




open MvPolynomial
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.FriedrichsExtension
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.QgOuterFockFL
open BookProof.NsFullEuler BookProof.FockSecondQuantization BookProof.FockSchur
open BookProof.HermiteGalerkin BookProof.NavierStokesFlow BookProof.StoneBridge
open BookProof.ChapterStoneResolvent BookProof.EsaClosure
open BookProof.EsaClosure
open BookProof.FockSecondQuantization
open BookProof.StoneBridge

noncomputable section

variable {D : Submodule ℂ (L2d 6)}

set_option maxHeartbeats 1000000 in
theorem solution (e : ℕ ≃ (Fin 6 →₀ ℕ)) (nu : ℝ) (k : Fin 3 → ℝ) :
    ∃ (T : UnboundedSelfAdjoint Fock) (U : ℝ → (Fock →L[ℂ] Fock)),
      IsSelfAdjointExtension (nsSpDGammaFried e nu k).op T.op ∧ IsStoneFlow T U :=
  exists_stone_flow_of_esa _ (nsSpDGammaFried_dom_dense e nu k) (nsSpDGammaFried e nu k).sym
      (nsSpDGamma_esa_farisLavine e nu k)

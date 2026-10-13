-- Generated from ChapterNsOneBodyDGamma.lean — solution of BookProof.NsOneBody.nsSpCol_apply
import Mathlib
import Definitions.Def_ChapterNsOneBodyDGamma
import Theorems.Thm_BookProof_FockSecondQuantization_opCol_apply
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterQgOuterFockFarisLavine
import Definitions.Def_ChapterNavierStokesFullEulerianFock
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterFockSchurEsa
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterHermiteProductCore
open BookProof.NsOneBody




open MvPolynomial
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.FriedrichsExtension
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.QgOuterFockFL
open BookProof.NsFullEuler BookProof.FockSecondQuantization BookProof.FockSchur
open BookProof.HermiteGalerkin BookProof.NavierStokesFlow BookProof.StoneBridge
open BookProof.ChapterStoneResolvent BookProof.EsaClosure
open BookProof.HermiteGalerkin
open BookProof.HermiteProductCore

noncomputable section

variable {D : Submodule ℂ (L2d 6)}

set_option maxHeartbeats 1000000 in
theorem solution (e : ℕ ≃ (Fin 6 →₀ ℕ)) (nu : ℝ) (k : Fin 3 → ℝ) (m j : ℕ) :
    nsSpCol e nu k m j
      = inner ℂ (coreBasis e j)
          ((nsOnePart e nu k ⟨coreBasis e m, Submodule.subset_span ⟨m, rfl⟩⟩ :
              finiteModeDomain (coreBasis e)) : L2d 6) := opCol_apply _ _ m j

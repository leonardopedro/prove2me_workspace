-- Generated from ChapterNavierStokesFullEulerianFock.lean — theorem BookProof.NsFullEuler.nsFullFock_friedrichs_extension
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterQgOuterFockEsa
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterQgOuterFockFarisLavine
import Definitions.Def_ChapterSirkTrotterKato
import Mathlib
import Definitions.Def_ChapterNavierStokesFullEulerianFock
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterA4
open BookProof.HermiteProductCore
open BookProof.YangMillsFriedrichs
open BookProof.NsFullEuler

variable {n : ℕ}



open MvPolynomial
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.FriedrichsExtension
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.QgOuterFock BookProof.StoneBridge BookProof.QgOuterFockFL
open BookProof.QgOuterFockInteractionFL BookProof.Qg3DGaugeFL
open BookProof.ChapterStoneResolvent

noncomputable section

theorem BookProof.NsFullEuler.nsFullFock_friedrichs_extension (nu lam mu gg : ℝ) :
    ∃ (Dom : Submodule ℂ nsFockSpace) (A : Dom →ₗ[ℂ] nsFockSpace),
      IsPositiveSelfAdjointExtension (nsFullFockHam nu lam mu gg) A := by sorry

-- Generated from ChapterNsFourierElimination.lean — theorem BookProof.NsFullEuler.nsRedFullOuterN_isPositiveSelfAdjointExtension
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterQgOuterFockEsa
import Definitions.Def_ChapterStoneBridge
import Mathlib
import Definitions.Def_ChapterNsFourierElimination
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterQgOuterFockFarisLavine
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterNavierStokesFullEulerianFock
open BookProof.DirectSumEsa
open BookProof.HermiteProductCore
open BookProof.QgOuterFockFL
open BookProof.YangMillsFriedrichs
open BookProof.NsFullEuler



open MvPolynomial
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.FriedrichsExtension
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.QgOuterFock BookProof.StoneBridge BookProof.QgOuterFockFL

noncomputable section

variable {n : ℕ}


theorem BookProof.NsFullEuler.nsRedFullOuterN_isPositiveSelfAdjointExtension (nu : ℝ) (k : Fin 3 → ℝ) :
    IsPositiveSelfAdjointExtension (nsRedFullFockHam nu k) (nsRedOuterComparison nu k).op := by sorry

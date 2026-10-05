-- Generated from ChapterNsFourierElimination.lean — theorem BookProof.NsFullEuler.nsRedFullOuterN_esa
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterQgOuterFockEsa
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterQgOuterFockFarisLavine
import Mathlib
import Definitions.Def_ChapterNsFourierElimination
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterNavierStokesFullEulerianFock
open BookProof.HermiteProductCore
open BookProof.NsFullEuler

variable {n : ℕ}



open MvPolynomial
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.FriedrichsExtension
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.QgOuterFock BookProof.StoneBridge BookProof.QgOuterFockFL

noncomputable section


theorem BookProof.NsFullEuler.nsRedFullOuterN_esa (nu : ℝ) (k : Fin 3 → ℝ) :
    EssentiallySelfAdjointOn (nsRedOuterComparison nu k).dom (nsRedOuterComparison nu k).op := by sorry

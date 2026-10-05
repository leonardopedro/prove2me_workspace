-- Generated from ChapterNsFourierElimination.lean — theorem BookProof.NsFullEuler.redFieldN_advect
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterQgOuterFockEsa
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterQgOuterFockFarisLavine
import Mathlib
import Definitions.Def_ChapterNsFourierElimination
import Definitions.Def_ChapterF7
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterNavierStokesFullEulerianFock
open BookProof.ChapterF7
open BookProof.HermiteProductCore
open BookProof.YangMillsHermite
open BookProof.NsFullEuler

variable {n : ℕ}



open MvPolynomial
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.FriedrichsExtension
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.QgOuterFock BookProof.StoneBridge BookProof.QgOuterFockFL

noncomputable section


theorem BookProof.NsFullEuler.redFieldN_advect (nu : ℝ) (k : Fin 3 → ℝ) (n : ℕ) (p : Fin n) (i : Fin 3) :
    redFieldN nu k n (finProdFinEquiv (p, imIdx7 i))
      = (coreRepPoly (n * 6)).op (mulOp (redAdvectPoly k n p i)) := by sorry

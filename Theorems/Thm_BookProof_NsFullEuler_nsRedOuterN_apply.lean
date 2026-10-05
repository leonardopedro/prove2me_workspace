-- Generated from ChapterNsFourierElimination.lean — theorem BookProof.NsFullEuler.nsRedOuterN_apply
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterQgOuterFockEsa
import Definitions.Def_ChapterStoneBridge
import Mathlib
import Definitions.Def_ChapterNsFourierElimination
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterQgOuterFockFarisLavine
import Definitions.Def_ChapterNavierStokesFullEulerianFock
open BookProof.HermiteProductCore
open BookProof.QgOuterFockFL
open BookProof.NsFullEuler

variable {n : ℕ}



open MvPolynomial
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.FriedrichsExtension
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.QgOuterFock BookProof.StoneBridge BookProof.QgOuterFockFL

noncomputable section


theorem BookProof.NsFullEuler.nsRedOuterN_apply (nu : ℝ) (k : Fin 3 → ℝ) (x : (nsRedOuterComparison nu k).dom)
    (n : ℕ) :
    (((nsRedOuterComparison nu k).op x : nsRedFockSpace) : ∀ n : ℕ, L2d (n * 6)) n
      = (redFried nu k n).op
          ⟨((x : nsRedFockSpace) : ∀ n : ℕ, L2d (n * 6)) n, x.2.1 n⟩ := by sorry

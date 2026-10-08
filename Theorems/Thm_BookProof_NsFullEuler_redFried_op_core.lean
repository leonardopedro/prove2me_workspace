-- Generated from ChapterNsFourierElimination.lean — theorem BookProof.NsFullEuler.redFried_op_core
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



open MvPolynomial
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.FriedrichsExtension
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.QgOuterFock BookProof.StoneBridge BookProof.QgOuterFockFL

noncomputable section

variable {n : ℕ}


theorem BookProof.NsFullEuler.redFried_op_core (nu : ℝ) (k : Fin 3 → ℝ) (n : ℕ) (p : polyGaussCore (d := n * 6))
    (h : (p : L2d (n * 6)) ∈ (redFried nu k n).dom) :
    (redFried nu k n).op ⟨(p : L2d (n * 6)), h⟩ = redHam nu k n p := by sorry

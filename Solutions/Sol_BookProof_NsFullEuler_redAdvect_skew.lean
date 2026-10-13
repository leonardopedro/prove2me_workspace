-- Generated from ChapterNsFourierElimination.lean — solution of BookProof.NsFullEuler.redAdvect_skew
import Mathlib
import Definitions.Def_ChapterNsFourierElimination
import Theorems.Thm_BookProof_NsFullEuler_coreRep_skewOn_op
import Theorems.Thm_BookProof_NsFullEuler_redAdvect_polySkew
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterQgOuterFockEsa
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterQgOuterFockFarisLavine
import Definitions.Def_ChapterF7
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterNavierStokesFullEulerianFock
open BookProof.NsFullEuler




open MvPolynomial
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.FriedrichsExtension
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.QgOuterFock BookProof.StoneBridge BookProof.QgOuterFockFL
open BookProof.ChapterF7
open BookProof.HermiteProductCore
open BookProof.YangMillsHermite

noncomputable section

variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (k : Fin 3 → ℝ) (n : ℕ) (m : Fin (n * 3))
    (x y : polyGaussCore (d := n * 6)) :
    inner ℂ (redAdvect k n m x) (y : L2d (n * 6))
      = -inner ℂ (x : L2d (n * 6)) (redAdvect k n m y) := coreRep_skewOn_op (coreRepPoly (n * 6)) (redAdvect_polySkew k n m) x y

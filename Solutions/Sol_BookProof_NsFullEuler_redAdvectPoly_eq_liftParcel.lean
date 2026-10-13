-- Generated from ChapterNsFourierElimination.lean — solution of BookProof.NsFullEuler.redAdvectPoly_eq_liftParcel
import Mathlib
import Definitions.Def_ChapterNsFourierElimination
import Theorems.Thm_BookProof_NsFullEuler_fourierAdvect_eq_transfer
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterQgOuterFockEsa
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterQgOuterFockFarisLavine
import Definitions.Def_ChapterNavierStokesFullEulerianFock
open BookProof.NsFullEuler




open MvPolynomial
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.FriedrichsExtension
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.QgOuterFock BookProof.StoneBridge BookProof.QgOuterFockFL

noncomputable section

variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (k : Fin 3 → ℝ) (n : ℕ) (p : Fin n) (i : Fin 3) :
    redAdvectPoly k n p i = liftParcel p (fourierAdvect k i) := by

  rw [redAdvectPoly, fourierAdvect_eq_transfer, map_sum]
  refine Finset.sum_congr rfl fun j _ => ?_
  simp only [map_mul, liftParcel_C, liftParcel_X, ruIdx]

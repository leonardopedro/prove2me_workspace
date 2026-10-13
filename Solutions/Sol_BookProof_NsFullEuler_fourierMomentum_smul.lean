-- Generated from ChapterNsFourierElimination.lean — solution of BookProof.NsFullEuler.fourierMomentum_smul
import Mathlib
import Definitions.Def_ChapterNsFourierElimination
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
theorem solution (t : ℝ) (k : Fin 3 → ℝ) :
    fourierMomentum (t • k) = C ((t : ℝ) : ℂ) * fourierMomentum k := by

  rw [fourierMomentum, fourierMomentum, Finset.mul_sum]
  refine Finset.sum_congr rfl fun j _ => ?_
  rw [Pi.smul_apply, smul_eq_mul, Complex.ofReal_mul, map_mul]
  ring

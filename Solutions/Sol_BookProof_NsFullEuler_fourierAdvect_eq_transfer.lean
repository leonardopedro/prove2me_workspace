-- Generated from ChapterNsFourierElimination.lean — solution of BookProof.NsFullEuler.fourierAdvect_eq_transfer
import Mathlib
import Definitions.Def_ChapterNsFourierElimination
open BookProof.NsFullEuler




open MvPolynomial
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.FriedrichsExtension
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.QgOuterFock BookProof.StoneBridge BookProof.QgOuterFockFL

noncomputable section

variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (k : Fin 3 → ℝ) (i : Fin 3) :
    fourierAdvect k i
      = ∑ j : Fin 3, C (((k j : ℝ)) : ℂ) * (X (ruIdx6 j) * X (ruIdx6 i)) := by

  rw [fourierAdvect, fourierMomentum, Finset.sum_mul]
  refine Finset.sum_congr rfl fun j _ => ?_
  ring

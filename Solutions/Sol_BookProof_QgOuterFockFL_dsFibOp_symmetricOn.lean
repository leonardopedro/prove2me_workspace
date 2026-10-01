-- Generated from ChapterQgOuterFockFarisLavine.lean — solution of BookProof.QgOuterFockFL.dsFibOp_symmetricOn
import Mathlib
import Definitions.Def_ChapterQgOuterFockFarisLavine
import Theorems.Thm_BookProof_QgOuterFockFL_dsFibOp_fib
open BookProof.QgOuterFockFL



open scoped ENNReal


open BookProof.FarisLavine
open BookProof.DirectSumEsa
open BookProof.QgOuterFock
open BookProof.YangMillsFriedrichs
open BookProof.FriedrichsExtension
open BookProof.FriedrichsExtension.FormDom
open BookProof.HashimotoShiftInvert
open BookProof.QgHermiteOscillator
open BookProof.HermiteProductCore

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {K : ℝ}
    (hrel : ∀ (i : ι) (u : (C i).dom), ‖H i u‖ ≤ K * ‖(C i).op u + (u : G i)‖)
    (hsym : ∀ i, SymmetricOn (C i).dom (H i)) :
    SymmetricOn (dsDom C) (dsFibOp C H K hrel) := by

  intro x y
  rw [lp.inner_eq_tsum, lp.inner_eq_tsum]
  refine tsum_congr fun i => ?_
  rw [dsFibOp_fib, dsFibOp_fib]
  exact hsym i (fib C x i) (fib C y i)

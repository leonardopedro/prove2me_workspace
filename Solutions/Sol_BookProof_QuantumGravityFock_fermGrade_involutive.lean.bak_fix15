-- Generated from ChapterQuantumGravityFock.lean — solution of BookProof.QuantumGravityFock.fermGrade_involutive
import Mathlib
import Definitions.Def_ChapterQuantumGravityFock
import Theorems.Thm_BookProof_QuantumGravityFock_fermGrade_apply
open BookProof.QuantumGravityFock




open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.NavierStokesFlow.FockOfFock BookProof.NavierStokesFlow.FullEsa
open BookProof.FarisLavine BookProof.StoneBridge BookProof.EsaClosure
open BookProof.ChapterStoneResolvent BookProof.YangMillsFriedrichs
open BookProof.HermiteGalerkin BookProof.HashimotoShiftInvert
open BookProof.FockSecondQuantization

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (u : FermAlg) : fermGrade (fermGrade u) = u := by

  refine Finsupp.ext fun α => ?_
  rw [fermGrade_apply, fermGrade_apply, ← mul_assoc, ← pow_add]
  rcases Nat.even_or_odd α.card with he | ho
  · rw [Even.neg_one_pow (he.add he), one_mul]
  · rw [Even.neg_one_pow (ho.add_odd ho), one_mul]

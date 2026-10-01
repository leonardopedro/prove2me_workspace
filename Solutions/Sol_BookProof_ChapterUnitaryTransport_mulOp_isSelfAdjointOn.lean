-- Generated from ChapterUnitaryTransport.lean — solution of BookProof.ChapterUnitaryTransport.mulOp_isSelfAdjointOn
import Mathlib
import Definitions.Def_ChapterUnitaryTransport
import Theorems.Thm_BookProof_ChapterUnitaryTransport_adjointDomain_mulOp
import Theorems.Thm_BookProof_ChapterUnboundedPosition_adjointDomain_eq_mulDomain
open BookProof.ChapterUnitaryTransport



open scoped InnerProductSpace


variable {H K : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
  [NormedAddCommGroup K] [InnerProductSpace ℂ K]

set_option maxHeartbeats 1000000 in
  rfl

theorem solution (f : ℤ → ℝ) : IsSelfAdjointOn (mulDomain f) (mu :=
  lOp f) := by
    rw [IsSelfAdjointOn, adjointDomain_mulOp]
    exact adjointDomain_eq_mulD

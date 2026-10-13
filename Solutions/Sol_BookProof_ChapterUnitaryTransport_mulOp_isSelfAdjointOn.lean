-- Generated from ChapterUnitaryTransport.lean — solution of BookProof.ChapterUnitaryTransport.mulOp_isSelfAdjointOn
import Mathlib
import Definitions.Def_ChapterUnitaryTransport
import Theorems.Thm_BookProof_ChapterUnitaryTransport_adjointDomain_mulOp
import Theorems.Thm_BookProof_ChapterUnboundedPosition_adjointDomain_eq_mulDomain
import Definitions.Def_ChapterContinuityUnitaryInfinite
import Definitions.Def_ChapterF7
import Definitions.Def_ChapterUnboundedPosition
open BookProof.ChapterUnitaryTransport



open scoped InnerProductSpace
open BookProof.ChapterContinuityUnitaryInfinite
open BookProof.ChapterF7
open BookProof.ChapterUnboundedPosition


variable {H K : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
  [NormedAddCommGroup K] [InnerProductSpace ℂ K]

variable {H K : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
  [NormedAddCommGroup K] [InnerProductSpace ℂ K]

set_option maxHeartbeats 1000000 in

theorem solution (f : ℤ → ℝ) : IsSelfAdjointOn (mulDomain f) (mulOp f) := by
  rw [IsSelfAdjointOn, adjointDomain_mulOp]
  exact adjointDomain_eq_mulDomain f

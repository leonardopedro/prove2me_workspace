-- Generated from ChapterUnitaryTransport.lean — theorem BookProof.ChapterUnitaryTransport.mulOp_isSelfAdjointOn
import Mathlib
import Definitions.Def_ChapterUnitaryTransport
open BookProof.ChapterUnitaryTransport

variable {H K : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
  [NormedAddCommGroup K] [InnerProductSpace ℂ K]


open scoped InnerProductSpace


variable {H K : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]
  [NormedAddCommGroup K] [InnerProductSpace ℂ K]

  rfl

theorem BookProof.ChapterUnitaryTransport.mulOp_isSelfAdjointOn (f : ℤ → ℝ) : IsSelfAdjointOn (mulDomain f) (mu := by sorry

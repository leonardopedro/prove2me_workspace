-- Generated from ChapterStatementOperator.lean — solution of BookProof.ChapterStatementOperator.ModelStatement.truthValue_not
import Mathlib
import Definitions.Def_ChapterStatementOperator
open BookProof.ChapterStatementOperator
open BookProof.ChapterStatementOperator.ModelStatement




open ContinuousLinearMap

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (S : ModelStatement H) (ψ : H)

set_option maxHeartbeats 1000000 in
theorem solution : S.not.truthValue ψ = ‖ψ‖ ^ 2 - S.truthValue ψ := by

  simp [truthValue, not_op, inner_sub_right, ← Complex.ofReal_pow]

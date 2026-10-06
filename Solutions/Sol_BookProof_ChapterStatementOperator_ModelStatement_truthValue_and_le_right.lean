-- Generated from ChapterStatementOperator.lean — solution of BookProof.ChapterStatementOperator.ModelStatement.truthValue_and_le_right
import Mathlib
import Definitions.Def_ChapterStatementOperator
open BookProof.ChapterStatementOperator
open BookProof.ChapterStatementOperator.ModelStatement




open ContinuousLinearMap

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (S : ModelStatement H) (ψ : H)

set_option maxHeartbeats 1000000 in
theorem solution (S T : ModelStatement H)
    (hcomm : S.op ∘L T.op = T.op ∘L S.op) :
    (S.and T hcomm).truthValue ψ ≤ T.truthValue ψ := by

  rw [truthValue_eq_norm_sq, truthValue_eq_norm_sq, and_op]
  have hle : ‖S.op (T.op ψ)‖ ≤ ‖T.op ψ‖ := S.norm_op_le (T.op ψ)
  simpa using pow_le_pow_left₀ (norm_nonneg (S.op (T.op ψ))) hle 2

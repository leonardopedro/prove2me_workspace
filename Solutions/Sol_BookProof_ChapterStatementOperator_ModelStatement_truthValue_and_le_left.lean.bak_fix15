-- Generated from ChapterStatementOperator.lean — solution of BookProof.ChapterStatementOperator.ModelStatement.truthValue_and_le_left
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
    (S.and T hcomm).truthValue ψ ≤ S.truthValue ψ := by

  rw [truthValue_eq_norm_sq, truthValue_eq_norm_sq, and_op]
  have h : S.op (T.op ψ) = T.op (S.op ψ) := by
    simpa using congrArg (fun A : H →L[ℂ] H => A ψ) hcomm
  have hle : ‖S.op (T.op ψ)‖ ≤ ‖S.op ψ‖ := by
    rw [h]; exact T.norm_op_le (S.op ψ)
  simpa using pow_le_pow_left₀ (norm_nonneg (S.op (T.op ψ))) hle 2

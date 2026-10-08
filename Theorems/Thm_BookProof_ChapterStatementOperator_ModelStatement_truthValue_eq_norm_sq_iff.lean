-- Generated from ChapterStatementOperator.lean — theorem BookProof.ChapterStatementOperator.ModelStatement.truthValue_eq_norm_sq_iff
import Mathlib
import Definitions.Def_ChapterStatementOperator
open BookProof.ChapterStatementOperator
open BookProof.ChapterStatementOperator



open ContinuousLinearMap

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

variable (S : ModelStatement H) (ψ : H)

theorem BookProof.ChapterStatementOperator.ModelStatement.truthValue_eq_norm_sq_iff : S.truthValue ψ = ‖ψ‖ ^ 2 ↔ S.op ψ = ψ := by sorry

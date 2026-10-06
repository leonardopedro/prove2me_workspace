-- Generated from ChapterStatementOperator.lean — theorem BookProof.ChapterStatementOperator.ModelStatement.truthValue_eq_zero_iff
import Mathlib
import Definitions.Def_ChapterStatementOperator
open BookProof.ChapterStatementOperator
open BookProof.ChapterStatementOperator

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (S : ModelStatement H) (ψ : H)



open ContinuousLinearMap


theorem BookProof.ChapterStatementOperator.ModelStatement.truthValue_eq_zero_iff : S.truthValue ψ = 0 ↔ S.op ψ = 0 := by sorry

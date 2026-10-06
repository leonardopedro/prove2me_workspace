-- Generated from ChapterStatementOperator.lean — theorem BookProof.ChapterStatementOperator.ModelStatement.truthValue_not
import Mathlib
import Definitions.Def_ChapterStatementOperator
open BookProof.ChapterStatementOperator
open BookProof.ChapterStatementOperator

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (S : ModelStatement H) (ψ : H)



open ContinuousLinearMap


theorem BookProof.ChapterStatementOperator.ModelStatement.truthValue_not : S.not.truthValue ψ = ‖ψ‖ ^ 2 - S.truthValue ψ := by sorry

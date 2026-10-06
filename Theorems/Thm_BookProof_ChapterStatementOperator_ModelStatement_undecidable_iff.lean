-- Generated from ChapterStatementOperator.lean — theorem BookProof.ChapterStatementOperator.ModelStatement.undecidable_iff
import Mathlib
import Definitions.Def_ChapterStatementOperator
open BookProof.ChapterStatementOperator
open BookProof.ChapterStatementOperator

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (S : ModelStatement H) (ψ : H)



open ContinuousLinearMap


theorem BookProof.ChapterStatementOperator.ModelStatement.undecidable_iff :
    S.Undecidable ↔ (∃ a : H, a ≠ 0 ∧ S.op a = a) ∧ (∃ b : H, b ≠ 0 ∧ S.op b = 0) := by sorry

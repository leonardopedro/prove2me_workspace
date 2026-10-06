-- Generated from ChapterStatementOperator.lean — theorem BookProof.ChapterStatementOperator.ModelStatement.truthValue_mem_unitInterval
import Mathlib
import Definitions.Def_ChapterStatementOperator
open BookProof.ChapterStatementOperator
open BookProof.ChapterStatementOperator

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (S : ModelStatement H) (ψ : H)



open ContinuousLinearMap


theorem BookProof.ChapterStatementOperator.ModelStatement.truthValue_mem_unitInterval (hψ : ‖ψ‖ = 1) :
    S.truthValue ψ ∈ Set.Icc (0 : ℝ) 1 := by sorry

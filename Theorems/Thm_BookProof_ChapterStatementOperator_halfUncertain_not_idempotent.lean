-- Generated from ChapterStatementOperator.lean — theorem BookProof.ChapterStatementOperator.halfUncertain_not_idempotent
import Mathlib
import Definitions.Def_ChapterStatementOperator
open BookProof.ChapterStatementOperator



open ContinuousLinearMap

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

variable (S : ModelStatement H) (ψ : H)

theorem BookProof.ChapterStatementOperator.halfUncertain_not_idempotent (h : ∃ ψ : H, ψ ≠ 0) :
    ¬ ((halfUncertain (H := H)).op ∘L (halfUncertain (H := H)).op
        = (halfUncertain (H := H)).op) := by sorry

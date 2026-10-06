-- Generated from ChapterStatementOperator.lean — theorem BookProof.ChapterStatementOperator.approximate_proof_error
import Mathlib
import Definitions.Def_ChapterStatementOperator
open BookProof.ChapterStatementOperator

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (S : ModelStatement H) (ψ : H)



open ContinuousLinearMap


theorem BookProof.ChapterStatementOperator.approximate_proof_error (S : ModelStatement H) (A : H →L[ℂ] H) (ε : ℝ)
    (hA : ‖A - S.op‖ ≤ ε) (ψ : H) :
    |RCLike.re (inner ℂ ψ (A ψ)) - S.truthValue ψ| ≤ ε * ‖ψ‖ ^ 2 := by sorry

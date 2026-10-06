-- Generated from ChapterStatementOperator.lean — theorem BookProof.ChapterStatementOperator.ModelStatement.truthValue_and_le_left
import Mathlib
import Definitions.Def_ChapterStatementOperator
import Definitions.Def_ChapterSirkGroupTransfer
open BookProof.ChapterSirkGroupTransfer
open BookProof.ChapterStatementOperator
open BookProof.ChapterStatementOperator

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable (S : ModelStatement H) (ψ : H)



open ContinuousLinearMap


theorem BookProof.ChapterStatementOperator.ModelStatement.truthValue_and_le_left (S T : ModelStatement H)
    (hcomm : S.op ∘L T.op = T.op ∘L S.op) :
    (S.and T hcomm).truthValue ψ ≤ S.truthValue ψ := by sorry

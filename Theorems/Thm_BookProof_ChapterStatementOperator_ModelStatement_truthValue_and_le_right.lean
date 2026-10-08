-- Generated from ChapterStatementOperator.lean — theorem BookProof.ChapterStatementOperator.ModelStatement.truthValue_and_le_right
import Mathlib
import Definitions.Def_ChapterStatementOperator
import Definitions.Def_ChapterSirkGroupTransfer
open BookProof.ChapterSirkGroupTransfer
open BookProof.ChapterStatementOperator
open BookProof.ChapterStatementOperator



open ContinuousLinearMap

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

variable (S : ModelStatement H) (ψ : H)

theorem BookProof.ChapterStatementOperator.ModelStatement.truthValue_and_le_right (S T : ModelStatement H)
    (hcomm : S.op ∘L T.op = T.op ∘L S.op) :
    (S.and T hcomm).truthValue ψ ≤ T.truthValue ψ := by sorry

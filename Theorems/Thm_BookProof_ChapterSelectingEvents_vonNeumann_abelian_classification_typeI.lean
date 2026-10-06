-- Generated from ChapterSelectingEvents.lean — theorem BookProof.ChapterSelectingEvents.vonNeumann_abelian_classification_typeI
import Mathlib
import Definitions.Def_ChapterSelectingEvents
import Definitions.Def_ChapterAbelianDiagonal
open BookProof.AbelianDiagonal
open BookProof.ChapterSelectingEvents

variable (H : Type*) [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable {Ω Data : Type*} [MeasurableSpace Ω]


open scoped BigOperators
open MeasureTheory ProbabilityTheory



theorem BookProof.ChapterSelectingEvents.vonNeumann_abelian_classification_typeI
    {ι : Type*} [Fintype ι] [DecidableEq ι] :
    Function.Injective
        (BookProof.AbelianDiagonal.diagonalStarAlgHom :
          (ι → ℂ) →⋆ₐ[ℂ] Matrix ι ι ℂ) ∧
      (∀ d e : ι → ℂ,
        Matrix.diagonal d * Matrix.diagonal e = Matrix.diagonal e * Matrix.diagonal d) ∧
      (∀ M : Matrix ι ι ℂ,
        (∀ d : ι → ℂ, M * Matrix.diagonal d = Matrix.diagonal d * M) ↔
          ∃ e : ι → ℂ, M = Matrix.diagonal e) := by sorry

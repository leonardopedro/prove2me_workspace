-- Generated from ChapterA4.lean — theorem BookProof.conjugateₗᵢ_symm
import Mathlib
import Definitions.Def_ChapterA4
open BookProof

variable {R E E' : Type*} [Semiring R]
    [SeminormedAddCommGroup E] [SeminormedAddCommGroup E'] [Module R E] [Module R E']



open MeasureTheory





theorem BookProof.conjugateₗᵢ_symm (Θ : E ≃ₗᵢ[R] E') (A : E ≃ₗᵢ[R] E) :
    (conjugateₗᵢ Θ A).symm = conjugateₗᵢ Θ A.symm := by sorry

-- Generated from ChapterA4.lean — solution of BookProof.conjugateₗᵢ_trans
import Mathlib
import Definitions.Def_ChapterA4
open BookProof




open MeasureTheory




variable {R E E' : Type*} [Semiring R]
    [SeminormedAddCommGroup E] [SeminormedAddCommGroup E'] [Module R E] [Module R E']

variable {R E E' : Type*} [Semiring R]
    [SeminormedAddCommGroup E] [SeminormedAddCommGroup E'] [Module R E] [Module R E']

set_option maxHeartbeats 1000000 in
theorem solution (Θ : E ≃ₗᵢ[R] E') (A B : E ≃ₗᵢ[R] E) :
    conjugateₗᵢ Θ (A.trans B) = (conjugateₗᵢ Θ A).trans (conjugateₗᵢ Θ B) := by

  ext x
  simp [conjugateₗᵢ]

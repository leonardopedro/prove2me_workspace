-- Generated from ChapterH9.lean — theorem BookProof.ChapterH9.exists_unit_eigenvector
import Definitions.Def_ChapterH1
import Definitions.Def_ChapterH4
import Definitions.Def_ChapterH5
import Definitions.Def_ChapterH6
import Definitions.Def_ChapterH8
import Mathlib
import Definitions.Def_ChapterH9
open BookProof.ChapterH9

variable {E F G : Type*}
  [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
  [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
  [NormedAddCommGroup G] [InnerProductSpace ℂ G] [CompleteSpace G]


noncomputable section


open BookProof.ChapterH1 BookProof.ChapterH4 BookProof.ChapterH5 BookProof.ChapterH6
open BookProof.ChapterH8
open ContinuousLinearMap



omit [CompleteSpace E] [CompleteSpace F] in
theorem BookProof.ChapterH9.exists_unit_eigenvector [FiniteDimensional ℂ F] (A : F →L[ℂ] F) {lam : ℂ}
    (hlam : lam ∈ spectrum ℂ (A : F →ₗ[ℂ] F)) : ∃ y : F, ‖y‖ = 1 ∧ A y = lam • y := by sorry

-- Generated from ChapterH5.lean — theorem BookProof.ChapterH5.krylov_subspace_span
import Mathlib
import Definitions.Def_ChapterH5
open BookProof.ChapterH5

variable {K E : Type*} [Field K] [AddCommGroup E] [Module K E]
variable {H : E →ₗ[K] E} {v : E}
variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]


noncomputable section



variable {K E : Type*} [Field K] [AddCommGroup E] [Module K E]

theorem BookProof.ChapterH5.krylov_subspace_span (H : E →ₗ[K] E) (v : E) (m : ℕ) :
    krylovSpan H v m = Submodule.span K {x | ∃ i < m, x = (H ^ i) v} := by sorry

-- Generated from ChapterH5.lean — theorem BookProof.ChapterH5.generator_bounded_of_rankOneProjector
import Mathlib
import Definitions.Def_ChapterH5
open BookProof.ChapterH5

variable {K E : Type*} [Field K] [AddCommGroup E] [Module K E]
variable {H : E →ₗ[K] E} {v : E}
variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]


noncomputable section



variable {K E : Type*} [Field K] [AddCommGroup E] [Module K E]

theorem BookProof.ChapterH5.generator_bounded_of_rankOneProjector (u : E) (hu : ‖u‖ = 1) (D : E →L[ℂ] E) :
    ‖rankOneProj u + D‖ ≤ 1 + ‖D‖ := by sorry

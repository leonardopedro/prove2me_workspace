-- Generated from ChapterH5.lean — theorem BookProof.ChapterH5.inversion_free_seed
import Mathlib
import Definitions.Def_ChapterH5
open BookProof.ChapterH5

variable {K E : Type*} [Field K] [AddCommGroup E] [Module K E]
variable {H : E →ₗ[K] E} {v : E}
variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]


noncomputable section



variable {K E : Type*} [Field K] [AddCommGroup E] [Module K E]

theorem BookProof.ChapterH5.inversion_free_seed (S R : E →ₗ[K] E) (v₀ : E) (m : ℕ)
    (hR : R.comp S = LinearMap.id) :
    R ((S ^ (m + 1)) v₀) = (S ^ m) v₀ := by sorry

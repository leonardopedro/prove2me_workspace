-- Generated from ChapterH5.lean — theorem BookProof.ChapterH5.krylov_no_inversion_eq_standard
import Mathlib
import Definitions.Def_ChapterH5
open BookProof.ChapterH5


noncomputable section



variable {K E : Type*} [Field K] [AddCommGroup E] [Module K E]

variable {H : E →ₗ[K] E} {v : E}

theorem BookProof.ChapterH5.krylov_no_inversion_eq_standard (H : E →ₗ[K] E) (γ : K) (v : E) (m : ℕ) :
    Submodule.span K {x | ∃ i < m, x = noInversionSeq H γ v i} = krylovSpan H v m := by sorry

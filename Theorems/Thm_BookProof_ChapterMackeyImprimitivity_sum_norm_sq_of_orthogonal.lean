-- Generated from ChapterMackeyImprimitivity.lean — theorem BookProof.ChapterMackeyImprimitivity.sum_norm_sq_of_orthogonal
import Mathlib
import Definitions.Def_ChapterMackeyImprimitivity
open BookProof.ChapterMackeyImprimitivity

variable {G : Type*} [Group G] {X : Type*} [Fintype X] [MulAction G X]
variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]


open scoped InnerProductSpace
open Finset



theorem BookProof.ChapterMackeyImprimitivity.sum_norm_sq_of_orthogonal {f : X → E} {ψ : E} (hsum : ∑ x, f x = ψ)
    (horth : ∀ x y, x ≠ y → ⟪f x, f y⟫_ℂ = 0) :
    ∑ x : X, ‖f x‖ ^ 2 = ‖ψ‖ ^ 2 := by sorry

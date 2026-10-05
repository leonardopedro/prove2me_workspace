-- Generated from ChapterOrthogonalSums.lean — theorem BookProof.ChapterOrthogonalSums.summable_of_orthogonal_of_summable_norm_sq
import Mathlib
import Definitions.Def_ChapterOrthogonalSums
open BookProof.ChapterOrthogonalSums

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]


open scoped InnerProductSpace



theorem BookProof.ChapterOrthogonalSums.summable_of_orthogonal_of_summable_norm_sq [CompleteSpace E] {ι : Type*} {v : ι → E}
    (horth : ∀ x y, x ≠ y → ⟪v x, v y⟫_ℂ = 0) (hsum : Summable fun x => ‖v x‖ ^ 2) :
    Summable v := by sorry

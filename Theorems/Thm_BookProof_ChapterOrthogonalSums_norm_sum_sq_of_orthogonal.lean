-- Generated from ChapterOrthogonalSums.lean — theorem BookProof.ChapterOrthogonalSums.norm_sum_sq_of_orthogonal
import Mathlib
import Definitions.Def_ChapterOrthogonalSums
open BookProof.ChapterOrthogonalSums


open scoped InnerProductSpace


variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]


theorem BookProof.ChapterOrthogonalSums.norm_sum_sq_of_orthogonal {ι : Type*} (t : Finset ι) {v : ι → E}
    (horth : ∀ x y, x ≠ y → ⟪v x, v y⟫_ℂ = 0) :
    ‖∑ x ∈ t, v x‖ ^ 2 = ∑ x ∈ t, ‖v x‖ ^ 2 := by sorry

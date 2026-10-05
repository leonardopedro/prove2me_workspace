-- Generated from ChapterOrthogonalSums.lean — theorem BookProof.ChapterOrthogonalSums.hasSum_norm_sq_of_hasSum
import Mathlib
import Definitions.Def_ChapterOrthogonalSums
open BookProof.ChapterOrthogonalSums

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]


open scoped InnerProductSpace



theorem BookProof.ChapterOrthogonalSums.hasSum_norm_sq_of_hasSum {ι : Type*} {v : ι → E} {psi : E} (h : HasSum v psi)
    (horth : ∀ x y, x ≠ y → ⟪v x, v y⟫_ℂ = 0) :
    HasSum (fun x => ‖v x‖ ^ 2) (‖psi‖ ^ 2) := by sorry

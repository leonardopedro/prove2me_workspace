-- Generated from ChapterOrthogonalSums.lean — theorem BookProof.ChapterOrthogonalSums.hasSum_smul_of_hasSum_norm_sq
import Mathlib
import Definitions.Def_ChapterOrthogonalSums
open BookProof.ChapterOrthogonalSums


open scoped InnerProductSpace


variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]


theorem BookProof.ChapterOrthogonalSums.hasSum_smul_of_hasSum_norm_sq [CompleteSpace E] {ι : Type*} {v : ι → E}
    (hv : Orthonormal ℂ v) {y : E}
    (h : HasSum (fun k => ‖⟪v k, y⟫_ℂ‖ ^ 2) (‖y‖ ^ 2)) :
    HasSum (fun k => ⟪v k, y⟫_ℂ • v k) y := by sorry

-- Generated from ChapterScaledDotProduct.lean — theorem BookProof.ChapterScaledDotProduct.rademacherMean_scaledDot_sq_of_unit_entries
import Definitions.Def_ChapterSoftmaxSharpness
import Mathlib
import Definitions.Def_ChapterScaledDotProduct
open BookProof.ChapterScaledDotProduct

variable {d : ℕ}


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness


theorem BookProof.ChapterScaledDotProduct.rademacherMean_scaledDot_sq_of_unit_entries (hd : 0 < d) {k : Fin d → ℝ}
    (hk : ∀ i, (k i) ^ 2 = 1) :
    rademacherMean (fun x => (scaledDot (signVec x) k) ^ 2) = 1 := by sorry

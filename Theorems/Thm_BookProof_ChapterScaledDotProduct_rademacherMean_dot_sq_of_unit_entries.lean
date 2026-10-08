-- Generated from ChapterScaledDotProduct.lean — theorem BookProof.ChapterScaledDotProduct.rademacherMean_dot_sq_of_unit_entries
import Definitions.Def_ChapterSoftmaxSharpness
import Mathlib
import Definitions.Def_ChapterScaledDotProduct
open BookProof.ChapterScaledDotProduct


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness

variable {d : ℕ}


theorem BookProof.ChapterScaledDotProduct.rademacherMean_dot_sq_of_unit_entries {k : Fin d → ℝ} (hk : ∀ i, (k i) ^ 2 = 1) :
    rademacherMean (fun x => (dot (signVec x) k) ^ 2) = (d : ℝ) := by sorry

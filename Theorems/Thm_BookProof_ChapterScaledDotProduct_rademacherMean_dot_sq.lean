-- Generated from ChapterScaledDotProduct.lean — theorem BookProof.ChapterScaledDotProduct.rademacherMean_dot_sq
import Definitions.Def_ChapterSoftmaxSharpness
import Mathlib
import Definitions.Def_ChapterScaledDotProduct
open BookProof.ChapterScaledDotProduct

variable {d : ℕ}


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness


theorem BookProof.ChapterScaledDotProduct.rademacherMean_dot_sq (k : Fin d → ℝ) :
    rademacherMean (fun x => (dot (signVec x) k) ^ 2) = ∑ i, (k i) ^ 2 := by sorry

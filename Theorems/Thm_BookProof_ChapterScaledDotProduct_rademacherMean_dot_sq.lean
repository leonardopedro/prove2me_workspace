-- Generated from ChapterScaledDotProduct.lean — theorem BookProof.ChapterScaledDotProduct.rademacherMean_dot_sq
import Definitions.Def_ChapterSoftmaxSharpness
import Mathlib
import Definitions.Def_ChapterScaledDotProduct
open BookProof.ChapterScaledDotProduct


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness

variable {d : ℕ}


theorem BookProof.ChapterScaledDotProduct.rademacherMean_dot_sq (k : Fin d → ℝ) :
    rademacherMean (fun x => (dot (signVec x) k) ^ 2) = ∑ i, (k i) ^ 2 := by sorry

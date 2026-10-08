-- Generated from ChapterScaledDotProduct.lean — theorem BookProof.ChapterScaledDotProduct.rademacherMean_dot
import Definitions.Def_ChapterSoftmaxSharpness
import Mathlib
import Definitions.Def_ChapterScaledDotProduct
open BookProof.ChapterScaledDotProduct


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness

variable {d : ℕ}


theorem BookProof.ChapterScaledDotProduct.rademacherMean_dot (k : Fin d → ℝ) :
    rademacherMean (fun x => dot (signVec x) k) = 0 := by sorry

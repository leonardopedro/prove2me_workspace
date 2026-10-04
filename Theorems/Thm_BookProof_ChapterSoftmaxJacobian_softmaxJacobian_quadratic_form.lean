-- Generated from ChapterSoftmaxJacobian.lean — theorem BookProof.ChapterSoftmaxJacobian.softmaxJacobian_quadratic_form
import Mathlib
import Definitions.Def_ChapterSoftmaxJacobian
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterA4
open BookProof.ChapterSoftmaxSharpness
open BookProof.ChapterSoftmaxJacobian

variable {m : ℕ}


open scoped BigOperators

noncomputable section




theorem BookProof.ChapterSoftmaxJacobian.softmaxJacobian_quadratic_form (beta : ℝ) (s x : Fin m → ℝ) :
    ∑ i, ∑ j, x i * softmaxJacobian beta s i j * x j = beta * weightedVar beta s x := by sorry

-- Generated from ChapterSoftmaxJacobian.lean — theorem BookProof.ChapterSoftmaxJacobian.softmaxJacobian_posSemidef
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterSoftmaxJacobian
open BookProof.ChapterSoftmaxJacobian

variable {m : ℕ}


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder


theorem BookProof.ChapterSoftmaxJacobian.softmaxJacobian_posSemidef {beta : ℝ} (hb : 0 ≤ beta) (s x : Fin m → ℝ) (i : Fin m) :
    0 ≤ ∑ i, ∑ j, x i * softmaxJacobian beta s i j * x j := by sorry

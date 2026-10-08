-- Generated from ChapterSoftmaxJacobian.lean — theorem BookProof.ChapterSoftmaxJacobian.softmaxJacobian_offDiag_nonpos
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterSoftmaxJacobian
import Definitions.Def_ChapterSoftmaxSharpness
open BookProof.ChapterSoftmaxSharpness
open BookProof.ChapterSoftmaxJacobian


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m : ℕ}


theorem BookProof.ChapterSoftmaxJacobian.softmaxJacobian_offDiag_nonpos {beta : ℝ} (hb : 0 ≤ beta) (s : Fin m → ℝ)
    {i j : Fin m} (hij : j ≠ i) : softmaxJacobian beta s i j ≤ 0 := by sorry

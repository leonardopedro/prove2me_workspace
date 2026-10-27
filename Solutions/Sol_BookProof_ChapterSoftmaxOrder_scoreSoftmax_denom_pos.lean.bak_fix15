-- Generated from ChapterSoftmaxOrder.lean — solution of BookProof.ChapterSoftmaxOrder.scoreSoftmax_denom_pos
import Mathlib
import Definitions.Def_ChapterSoftmaxOrder
open BookProof.ChapterSoftmaxOrder



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxBorn BookProof.ChapterSoftmaxSharpness

variable {m : ℕ}

variable {m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (beta : ℝ) (s : Fin m → ℝ) (i : Fin m) :
    0 < ∑ l, Real.exp (beta * s l) := Finset.sum_pos (fun _ _ => Real.exp_pos _) ⟨i, Finset.mem_univ i⟩

-- Generated from ChapterObservableExpectation.lean — solution of BookProof.ChapterObservableExpectation.bayesPosterior_sum_one
import Mathlib
import Definitions.Def_ChapterObservableExpectation
open BookProof.ChapterObservableExpectation



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxBorn

variable {m n : ℕ}
variable {E : Type*} [AddCommGroup E] [Module ℝ E]

variable {m n : ℕ}
variable {E : Type*} [AddCommGroup E] [Module ℝ E]
variable {Y : Type*}

set_option maxHeartbeats 1000000 in
theorem solution {prior : Fin m → ℝ} {L : Fin m → Y → ℝ} (y : Y)
    (hy : 0 < evidence prior L y) : ∑ x, posterior prior L y x = 1 := by

  have h : ∑ x, posterior prior L y x = evidence prior L y / evidence prior L y := by
    simp [posterior, evidence, Finset.sum_div]
  rw [h, div_self hy.ne']

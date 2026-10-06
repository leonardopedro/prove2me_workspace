-- Generated from ChapterHierarchicalBayesComposition.lean — solution of BookProof.ChapterHierarchicalBayesComposition.terminalMarginal_comp
import Mathlib
import Definitions.Def_ChapterHierarchicalBayesComposition
open BookProof.ChapterHierarchicalBayesComposition



open scoped BigOperators


variable {A B C D : Type*}
  [Fintype A] [Fintype B] [Fintype C] [Fintype D]
  [DecidableEq A] [DecidableEq B] [DecidableEq C] [DecidableEq D]

variable {A B C D : Type*}
  [Fintype A] [Fintype B] [Fintype C] [Fintype D]
  [DecidableEq A] [DecidableEq B] [DecidableEq C] [DecidableEq D]

set_option maxHeartbeats 1000000 in
theorem solution (k₁ : A → B → ℝ) (k₂ : B → C → ℝ)
    (likelihood : C → ℝ) :
    terminalMarginal k₁ (terminalMarginal k₂ likelihood) =
      terminalMarginal (compKernel k₁ k₂) likelihood := by

  funext a
  unfold terminalMarginal compKernel
  simp_rw [Finset.mul_sum, Finset.sum_mul]
  rw [Finset.sum_comm]
  apply Finset.sum_congr rfl
  intro c hc
  apply Finset.sum_congr rfl
  intro b hb
  ring

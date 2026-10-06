-- Generated from ChapterHierarchicalBayesComposition.lean — solution of BookProof.ChapterHierarchicalBayesComposition.compKernel_normalized
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
    (h₁ : IsNormalizedKernel k₁) (h₂ : IsNormalizedKernel k₂) :
    IsNormalizedKernel (compKernel k₁ k₂) := by

  intro a
  unfold compKernel
  calc
    ∑ c, ∑ b, k₁ a b * k₂ b c = ∑ b, ∑ c, k₁ a b * k₂ b c :=
      Finset.sum_comm
    _ = ∑ b, k₁ a b * ∑ c, k₂ b c := by
      apply Finset.sum_congr rfl
      intro b hb
      rw [Finset.mul_sum]
    _ = ∑ b, k₁ a b := by
      apply Finset.sum_congr rfl
      intro b hb
      rw [h₂ b, mul_one]
    _ = 1 := h₁ a

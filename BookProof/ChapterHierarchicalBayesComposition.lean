import Mathlib
import BookProof.ChapterHierarchicalBayes

/-!
# Composition of finite Bayesian hierarchies

This module continues the formalization of §11 of "Aligned deep learning as a
random sampling method" (`book.tex` around line 10484).  The book says that a
hierarchical inference problem may have as many levels as desired.  The earlier
`ChapterHierarchicalBayes` treats two levels.  Here finite conditional kernels
are equipped with an associative composition operation.  Closure under
normalization and nonnegativity, together with associativity and the
marginalization law, makes arbitrary finite hierarchies compositional: adjacent
levels may be collapsed in any order without changing the resulting likelihood.
-/

open scoped BigOperators

namespace BookProof.ChapterHierarchicalBayesComposition

variable {A B C D : Type*}
  [Fintype A] [Fintype B] [Fintype C] [Fintype D]
  [DecidableEq A] [DecidableEq B] [DecidableEq C] [DecidableEq D]

/-- Composition of two finite conditional kernels, obtained by summing out the
intermediate state. -/
def compKernel (k₁ : A → B → ℝ) (k₂ : B → C → ℝ) (a : A) (c : C) : ℝ :=
  ∑ b, k₁ a b * k₂ b c

/-- A finite conditional kernel is normalized at every input. -/
def IsNormalizedKernel (k : A → B → ℝ) : Prop :=
  ∀ a, ∑ b, k a b = 1

/-- A finite conditional kernel is pointwise nonnegative. -/
def IsNonnegativeKernel (k : A → B → ℝ) : Prop :=
  ∀ a b, 0 ≤ k a b

omit [Fintype A] [Fintype C] [DecidableEq A] [DecidableEq B] [DecidableEq C] in
/-- Composition preserves pointwise nonnegativity. -/
theorem compKernel_nonnegative (k₁ : A → B → ℝ) (k₂ : B → C → ℝ)
    (h₁ : IsNonnegativeKernel k₁) (h₂ : IsNonnegativeKernel k₂) :
    IsNonnegativeKernel (compKernel k₁ k₂) := by
  intro a c
  exact Finset.sum_nonneg fun b _ => mul_nonneg (h₁ a b) (h₂ b c)

omit [Fintype A] [DecidableEq A] [DecidableEq B] [DecidableEq C] in
/-- Composition preserves normalization. -/
theorem compKernel_normalized (k₁ : A → B → ℝ) (k₂ : B → C → ℝ)
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

omit [Fintype A] [Fintype D] [DecidableEq A] [DecidableEq B] [DecidableEq C] [DecidableEq D] in
/-- Composition of finite kernels is associative. -/
theorem compKernel_assoc (k₁ : A → B → ℝ) (k₂ : B → C → ℝ)
    (k₃ : C → D → ℝ) :
    compKernel (compKernel k₁ k₂) k₃ = compKernel k₁ (compKernel k₂ k₃) := by
  funext a d
  unfold compKernel
  simp_rw [Finset.sum_mul, Finset.mul_sum]
  rw [Finset.sum_comm]
  apply Finset.sum_congr rfl
  intro c hc
  apply Finset.sum_congr rfl
  intro b hb
  ring

/-- The identity conditional kernel. -/
def idKernel (a a' : A) : ℝ := if a = a' then 1 else 0

/-- The identity kernel is normalized. -/
theorem idKernel_normalized : IsNormalizedKernel (idKernel : A → A → ℝ) := by
  intro a
  simp [idKernel]

omit [Fintype A] in
/-- The identity kernel is nonnegative. -/
theorem idKernel_nonnegative : IsNonnegativeKernel (idKernel : A → A → ℝ) := by
  intro a a'
  by_cases h : a = a'
  · simp [idKernel, h]
  · simp [idKernel, h]

omit [Fintype B] [DecidableEq B] in
/-- The identity kernel is a left identity for composition. -/
theorem idKernel_comp (k : A → B → ℝ) :
    compKernel (idKernel : A → A → ℝ) k = k := by
  funext a b
  simp [compKernel, idKernel]

omit [Fintype A] [DecidableEq A] in
/-- The identity kernel is a right identity for composition. -/
theorem compKernel_id (k : A → B → ℝ) :
    compKernel k (idKernel : B → B → ℝ) = k := by
  funext a b
  simp [compKernel, idKernel]

/-- Marginalize a terminal likelihood through one finite conditional kernel. -/
def terminalMarginal (k : A → B → ℝ) (likelihood : B → ℝ) (a : A) : ℝ :=
  ∑ b, k a b * likelihood b

omit [Fintype A] [DecidableEq A] [DecidableEq B] [DecidableEq C] in
/-- Marginalizing two consecutive levels is the same as first composing their
conditional kernels and then marginalizing once. -/
theorem terminalMarginal_comp (k₁ : A → B → ℝ) (k₂ : B → C → ℝ)
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

omit [DecidableEq A] [DecidableEq B] [DecidableEq C] in
/-- A three-level terminal likelihood gives the same outer posterior after the
two conditional levels are collapsed into their composite kernel. -/
theorem threeLevel_outerPosterior_eq_bayesUpdate (outer : A → ℝ)
    (k₁ : A → B → ℝ) (k₂ : B → C → ℝ) (likelihood : C → ℝ) :
    BookProof.ChapterHierarchicalBayes.outerPosterior outer
        (compKernel k₁ k₂) (fun _ c => likelihood c) =
      BookProof.ChapterSequentialBayes.bayesUpdate outer
        (BookProof.ChapterHierarchicalBayes.marginalLikelihood
          (compKernel k₁ k₂) (fun _ c => likelihood c)) := by
  exact BookProof.ChapterHierarchicalBayes.outerPosterior_eq_bayesUpdate
    outer (compKernel k₁ k₂) (fun _ c => likelihood c)

end BookProof.ChapterHierarchicalBayesComposition

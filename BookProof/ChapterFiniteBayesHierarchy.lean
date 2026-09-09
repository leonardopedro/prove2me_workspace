import Mathlib
import BookProof.ChapterHierarchicalBayesComposition

/-!
# Arbitrary finite Bayesian hierarchies

This module makes the “as many levels as we wish” claim in §11 of
*Aligned deep learning as a random sampling method* (`book.tex` around line
10484) explicit for a homogeneous finite latent-state space.  A list of
conditional kernels is collapsed to one kernel.  The collapse remains a
normalized nonnegative kernel, concatenation becomes kernel composition, and
recursively marginalizing through every level agrees with one marginalization
through the collapsed kernel.
-/

open scoped BigOperators

namespace BookProof.ChapterFiniteBayesHierarchy

open BookProof.ChapterHierarchicalBayesComposition

variable {S : Type*} [Fintype S] [DecidableEq S]

/-- Collapse a finite list of transition kernels in temporal order. -/
def collapseKernels : List (S → S → ℝ) → (S → S → ℝ)
  | [] => idKernel
  | k :: ks => compKernel k (collapseKernels ks)

@[simp] theorem collapseKernels_nil :
    collapseKernels ([] : List (S → S → ℝ)) = idKernel := by
  rfl

@[simp] theorem collapseKernels_cons (k : S → S → ℝ)
    (ks : List (S → S → ℝ)) :
    collapseKernels (k :: ks) = compKernel k (collapseKernels ks) := by
  rfl

/-- Collapsing concatenated hierarchies is kernel composition. -/
theorem collapseKernels_append (ks₁ ks₂ : List (S → S → ℝ)) :
    collapseKernels (ks₁ ++ ks₂) =
      compKernel (collapseKernels ks₁) (collapseKernels ks₂) := by
  induction ks₁ with
  | nil => simp [idKernel_comp]
  | cons k ks₁ ih => 
    simp [ih, compKernel_assoc]

/-- Every finite composition of normalized kernels is normalized. -/
theorem collapseKernels_normalized (ks : List (S → S → ℝ))
    (hks : ∀ k ∈ ks, IsNormalizedKernel k) :
    IsNormalizedKernel (collapseKernels ks) := by
  induction ks with
  | nil => exact idKernel_normalized
  | cons k ks ih => 
    simp only [collapseKernels]
    exact compKernel_normalized k (collapseKernels ks) (hks k (by simp)) (ih fun k hk => hks k
                                                                  (by simp only [List.mem_cons];
                                                                      exact Or.inr hk))

/-- Every finite composition of nonnegative kernels is nonnegative. -/
theorem collapseKernels_nonnegative (ks : List (S → S → ℝ))
    (hks : ∀ k ∈ ks, IsNonnegativeKernel k) :
    IsNonnegativeKernel (collapseKernels ks) := by
  induction ks with
  | nil => exact idKernel_nonnegative
  | cons k ks ih =>
    simp only [collapseKernels]
    exact compKernel_nonnegative k (collapseKernels ks) (hks k (by simp))
      (ih fun k hk => hks k (by simp only [List.mem_cons]; exact Or.inr hk))

/-- Recursively marginalize a terminal likelihood through all hierarchy levels. -/
def nestedMarginal : List (S → S → ℝ) → (S → ℝ) → (S → ℝ)
  | [], likelihood => likelihood
  | k :: ks, likelihood => terminalMarginal k (nestedMarginal ks likelihood)

/-- Arbitrarily deep finite marginalization equals one marginalization through
its collapsed kernel. -/
theorem nestedMarginal_eq_terminalMarginal (ks : List (S → S → ℝ))
    (likelihood : S → ℝ) :
    nestedMarginal ks likelihood =
      terminalMarginal (collapseKernels ks) likelihood := by
  induction ks with
  | nil =>
    simp only [nestedMarginal, collapseKernels_nil]
    funext a
    simp [terminalMarginal, idKernel]
  | cons k ks ih =>
    simp only [nestedMarginal, collapseKernels_cons]
    rw [ih]
    exact terminalMarginal_comp k (collapseKernels ks) likelihood

end BookProof.ChapterFiniteBayesHierarchy

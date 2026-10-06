import Definitions.Def_ChapterHierarchicalBayesComposition
import Mathlib


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







/-- Recursively marginalize a terminal likelihood through all hierarchy levels. -/
def nestedMarginal : List (S → S → ℝ) → (S → ℝ) → (S → ℝ)
  | [], likelihood => likelihood
  | k :: ks, likelihood => terminalMarginal k (nestedMarginal ks likelihood)



end BookProof.ChapterFiniteBayesHierarchy

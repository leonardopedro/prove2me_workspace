import Mathlib
import BookProof.ChapterPaFreeCompletion

/-!
# Definability / Conservativity Fragment

This module formalizes the precise, provable fragment of the claim that
the completion of the finitely-supported core does not leak provability
assumptions (PA / Gödelian self-reference).

The full metamathematical claim "the completion is a conservative extension"
is documented here but NOT formalized as a Lean theorem. The formal content
is the `Finsupp.finite_support` lemma: in the finitely-supported fragment,
every denotable vector is finitely supported.

**Update (August 2026).**  The former `True` placeholder
`conservativity_documentation` has been replaced by the genuine mathematical
core of the claim, `completion_conservative_over_core`: the image of the
term-denotable fragment inside `ℓ²(ℕ)` is *exactly* the set of
finitely-supported vectors, it is dense, and it is a proper subset.  What
remains metamathematical (and is not claimed as a Lean theorem) is only the
proof-theoretic reading of that fact.
-/

open Finset
open BookProof.ChapterRieszFischer

/-- In the finitely-supported fragment, every vector is finitely supported.
    This is the core definability result: there are no "infinite" vectors
    definable in the finite-support language. -/
theorem finitely_supported_vectors_are_finite (v : ℕ →₀ ℝ) :
    (v.support : Set ℕ).Finite := by
  simp

/-- No vector in the completion is term-denotable unless it is finitely supported.
    This is the contrapositive: if a vector requires infinite support,
    it cannot be constructed from finitely many basis vectors. -/
theorem non_finitely_supported_not_term_denotable (v : ℕ → ℝ)
    (h_infinite : ¬ (Function.support v).Finite) :
    v ∉ Set.range (fun (w : ℕ →₀ ℝ) => fun n => w n) := by
  intro h
  rcases h with ⟨w, hw⟩
  apply h_infinite
  rw [← hw]
  exact Finsupp.finite_support w

/-- **The mathematical core of conservativity.**  Inside the completion
`ℓ²(ℕ)`, the image of the term-denotable fragment `ℕ →₀ ℝ` is *exactly* the set
of finitely-supported vectors; that set is dense; and it is a proper subset.

So the completion adds no term-denotable vector beyond those already present
(every new element has infinite support, hence is not term-denotable), while
still being the closure of the fragment.

This replaces the earlier `True` placeholder.  The remaining, purely
proof-theoretic reading of the statement ("the completion is a conservative
extension of the base theory") is *not* claimed here. -/
theorem completion_conservative_over_core :
    Set.range ofCore = FinSupport ∧ Dense (Set.range ofCore) ∧
      Set.range ofCore ≠ (Set.univ : Set Ell2) :=
  ⟨range_ofCore, denseCore_dense, denseCore_proper⟩

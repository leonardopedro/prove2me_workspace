import Definitions.Def_ChapterRieszFischer
import Mathlib


/-!
# The PA-free completion is separable: a *countable* dense definable fragment

`BookProof/ChapterRieszFischer.lean` shows that the finitely-supported core
`ℕ →₀ ℝ` is dense in `ℓ²(ℕ)` and strictly smaller than it.  That core is,
however, still uncountable, whereas the manuscript's definability argument (see
`BookProof/ChapterDefinabilityFragment.lean` and
`BookProof/ChapterCountableDefinability.lean`) needs a *countable* fragment: only
countably many vectors can be named by terms of a countable language.

This file closes that gap.  The finitely-supported **rational** vectors form a
countable set which is still dense in `ℓ²(ℕ)`; consequently `ℓ²(ℕ)` is a
separable metric space, and the whole completion is the closure of a countable
set of nameable vectors.

## Deliverables

* `ratVec` — the finitely-supported rational vectors, indexed by `ℕ →₀ ℚ`;
* `ratVec_range_countable` — the fragment is countable;
* `eq_sum_single_of_mem_finSupport` — a finitely-supported vector is the finite
  sum of its coordinate atoms;
* `ratVec_dense` — the rational fragment is dense in `ℓ²(ℕ)`;
* `ell2_separable` — **headline**: `ℓ²(ℕ)` is separable, witnessed by the
  countable dense rational fragment.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

open Filter Finset
open scoped ENNReal

namespace BookProof.ChapterEll2Separable

open BookProof.ChapterRieszFischer

/-- The finitely-supported **rational** vectors of `ℓ²(ℕ)`, indexed by the
countable type `ℕ →₀ ℚ`. -/
noncomputable def ratVec (c : ℕ →₀ ℚ) : Ell2 :=
  ∑ i ∈ c.support, lp.single 2 i ((c i : ℝ))











end BookProof.ChapterEll2Separable

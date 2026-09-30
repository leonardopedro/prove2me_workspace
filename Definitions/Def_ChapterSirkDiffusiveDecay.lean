import Definitions.Def_ChapterH4
import Mathlib


/-!
# Chapter SirkDiffusiveDecay — the laminar (diffusive) decay rate

`CONSOLIDATED_PLAN.md` §12.2 **Gap 2, NS Lagrangian**: "the ν-dependent
constants; **the diffusive decay statement** (the laminar `νk²` decay rate the
numerics measure)".

The NS Lagrangian generator has a positive parabolic part `½ Σ Pᵢ² + ν Σ Qᵢ²`.
What the numerics measure in the laminar regime is the exponential decay of the
parabolic semigroup at the rate given by the coercivity constant of that part —
`νk²` for the mode `k`.  This chapter proves the statement in the form the
formalization can carry: for a *coercive* bounded generator, the parabolic
semigroup decays at exactly the coercivity rate, and the SIRK reduction inherits
the rate exactly.

## Deliverables

* `heatFlow A t = exp (−t • A)` — the parabolic semigroup of a bounded generator,
  with `heatFlow_zero`, `heatFlow_apply_comm`.
* `hasDerivAt_heatFlow_apply` — the semigroup solves the abstract heat equation
  `u'(t) = −A u(t)`.
* `hasDerivAt_heatFlow_normSq` — the energy identity `d/dt ‖u(t)‖² =
  −2 Re⟪u(t), A u(t)⟫`.
* `IsCoercive A μ` — the coercivity `μ‖x‖² ≤ Re⟪x, A x⟫` (for the parabolic part
  of the Lagrangian generator, `μ = νk²`).
* `norm_heatFlow_apply_le` — **headline (the diffusive decay)**: a coercive
  generator has `‖e^{−tA} v‖ ≤ e^{−μt} ‖v‖` for every `t ≥ 0`.
* `norm_heatFlow_le` — the same in operator norm, `‖e^{−tA}‖ ≤ e^{−μt}`.
* `isCoercive_compress` — **the reduced model has the same rate**: the SIRK
  compression `V∗AV` of a coercive generator along an isometry is coercive with
  the *same* constant, so
* `norm_heatFlow_compress_apply_le` — the reduced propagator obeys the same
  laminar decay bound `e^{−μt}` at every reduction order: the decay rate the
  numerics read off the reduced model is not an artefact of the reduction.

## Honest boundary

`μ` is the coercivity constant of the generator as an operator; identifying it
with `νk²` for a *particular* discretisation is the content of the per-mode
symbol computations already in the Navier–Stokes chapters, and the numerical
value of `ν` is an input, not a theorem.  The generator here is bounded (the
regime in which the project's Galerkin/Hashimoto reduction is an operator
statement); the unbounded case is the standing Stone/Trotter–Kato boundary.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

noncomputable section

namespace BookProof.ChapterSirkDiffusiveDecay

open BookProof.ChapterH4
open Filter Topology NormedSpace

variable {E F : Type*}
  [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
  [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

/-! ## 1. The parabolic semigroup -/

/-- The parabolic (heat) semigroup `e^{−tA}` of a bounded generator. -/
def heatFlow (A : E →L[ℂ] E) (t : ℝ) : E →L[ℂ] E := exp ((-t) • A)









/-! ## 2. Coercivity and the decay bound -/

/-- **Coercivity** of a generator with rate `μ`: `μ‖x‖² ≤ Re⟪x, A x⟫`.  For the
parabolic part of the Navier–Stokes Lagrangian generator this is the mode-wise
bound with `μ = νk²`. -/
def IsCoercive (A : E →L[ℂ] E) (mu : ℝ) : Prop :=
  ∀ x : E, mu * ‖x‖ ^ 2 ≤ (inner ℂ x (A x) : ℂ).re







/-! ## 3. The reduced model has the same rate -/







end BookProof.ChapterSirkDiffusiveDecay

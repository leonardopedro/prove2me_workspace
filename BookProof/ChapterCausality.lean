import BookProof.ChapterInverseTransform

/-!
# Chapter — Any deterministic theory compatible with relativistic QM respects causality

Source: `book.tex`, chapter *"Reconstructing the classical trajectory of any isolated
quantum system"*, §*"Any deterministic theory compatible with relativistic Quantum
Mechanics necessarily respects relativistic causality"* (line ~2915).

The book's argument is:

> *"A deterministic theory compatible with relativistic Quantum Mechanics is one
> which, when applied to an ensemble of free systems, will reproduce the
> statistical predictions of Quantum Mechanics. Since in relativistic Quantum
> Mechanics the probability that the system moves faster than light is null, then
> no system (described by the deterministic theory) in the ensemble moves faster
> than light. Thus any deterministic theory compatible with relativistic Quantum
> Mechanics necessarily respects relativistic causality."*

We formalize this on top of the explicit deterministic decoder built in
`ChapterInverseTransform`: the ensemble is indexed by a uniform seed `u ∈ [0,1)`,
and the member with seed `u` yields the outcome `k` with `u ∈ seedSet p k`.  The
book's phrase *"the system moves faster than light"* corresponds to the outcome
lying in a distinguished finite set `S ⊆ {0, …, n-1}` of *faster-than-light*
outcomes; *"the probability that the system moves faster than light is null"* is
the quantum prediction `∑_{k ∈ S} p k = 0`.

The set of ensemble members whose outcome is in `S` is exactly the union of the
corresponding seed intervals, `⋃_{k ∈ S} seedSet p k`.  The main results are:

* `seedSet_biUnion_measure` — the measure of the members with an outcome in `S`
  is exactly `∑_{k ∈ S} p k` (the deterministic ensemble reproduces the quantum
  probability of *any* set of outcomes, not just single outcomes);
* `causality` — if Quantum Mechanics predicts a **null** faster-than-light
  probability (`∑_{k ∈ S} p k = 0`), then the set of ensemble members that move
  faster than light is a **null set**: *almost no* deterministic member violates
  causality;
* `causality_ae` — the a.e. reformulation: for **almost every** seed `u ∈ [0,1)`,
  the member with seed `u` does **not** land in the faster-than-light set `S`.

Together these are the mathematical backbone of the book's claim that a
deterministic theory reproducing the statistics of relativistic Quantum Mechanics
cannot allow (with positive probability) any faster-than-light system, hence
respects relativistic causality.  (The surrounding physics — the Dirac
propagator vanishing for space-like separations, etc. — is prose and out of
scope.)
-/

namespace BookProof.Causality

open MeasureTheory Set
open BookProof.InverseTransform

variable (p : ℕ → ℝ)

/-- **The deterministic ensemble reproduces the quantum probability of any set of
outcomes.**  The Lebesgue measure of the set of ensemble members (seeds) whose
decoded outcome lies in the finite set `S` equals `∑_{k ∈ S} p k`.  For a single
outcome this is `seedSet_measure`; here we handle an arbitrary finite union,
using pairwise disjointness of the seed intervals. -/
theorem seedSet_biUnion_measure (hp : ∀ i, 0 ≤ p i) (S : Finset ℕ) :
    volume (⋃ k ∈ S, seedSet p k) = ENNReal.ofReal (∑ k ∈ S, p k) := by
  rw [measure_biUnion_finset]
  · rw [Finset.sum_congr rfl fun k _ => seedSet_measure p k,
      ENNReal.ofReal_sum_of_nonneg fun i _ => hp i]
  · exact (seedSet_disjoint p hp).set_pairwise _
  · intro b _
    exact measurableSet_Ico

/-- **Relativistic causality of the deterministic ensemble.**
If Quantum Mechanics predicts that the probability of a faster-than-light outcome
is null (`∑_{k ∈ S} p k = 0`, where `S` collects the faster-than-light outcomes),
then the set of ensemble members that move faster than light,
`⋃_{k ∈ S} seedSet p k`, is a **null set**: with probability zero does the
deterministic theory produce a faster-than-light system. -/
theorem causality (hp : ∀ i, 0 ≤ p i) (S : Finset ℕ)
    (hnull : ∑ k ∈ S, p k = 0) :
    volume (⋃ k ∈ S, seedSet p k) = 0 := by
  rw [seedSet_biUnion_measure p hp S, hnull, ENNReal.ofReal_zero]

/-- **Almost-everywhere reformulation of causality.**
Under the quantum prediction of a null faster-than-light probability, for
**almost every** uniform seed `u ∈ [0,1)` the corresponding deterministic member
does *not* land in the faster-than-light set: `u ∉ ⋃_{k ∈ S} seedSet p k` for a.e.
`u`.  This is the precise sense of the book's *"no system in the ensemble moves
faster than light."* -/
theorem causality_ae (hp : ∀ i, 0 ≤ p i) (S : Finset ℕ)
    (hnull : ∑ k ∈ S, p k = 0) :
    ∀ᵐ u, u ∉ ⋃ k ∈ S, seedSet p k :=
  measure_eq_zero_iff_ae_notMem.mp (causality p hp S hnull)

end BookProof.Causality

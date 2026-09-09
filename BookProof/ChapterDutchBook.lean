import Mathlib

/-!
# The de Finetti Dutch-Book coherence theorem (finite sample space)

Source: `book.tex`, chapter *"Consciousness as a representation of a Bayesian
prior"*, §*"Non-informative priors vs. Fermi Paradox and Artificial General
Intelligence"* (`book.tex` line ~9142), where the book invokes the classical
**Dutch-book** argument (`\cite{dutchbook}`) underpinning the Bayesian
interpretation of probability that the whole book is built on: a system of
betting prices is *coherent* (cannot be turned into a guaranteed loss) **iff**
those prices are the expectations of a genuine probability distribution.

This module formalizes that statement (finite version, on a finite sample
space `Ω`).

## Setup

* An **event** is a `Finset Ω`; a **price function** `Pr : Finset Ω → ℝ`
  assigns each event its fair betting quotient.
* A **gamble** on an event `A` with stake `s` pays the bettor
  `s * (1_A(ω) - Pr A)` in state `ω` (they pay `s * Pr A` up front and
  receive `s` iff `A` occurs).  A finite family of gambles has total payoff
  `payoff Pr A s ω = ∑ i, s i * (1_{A i}(ω) - Pr (A i))`.
* `HasDutchBook Pr` — there is a finite family of gambles whose payoff is
  **strictly negative in every state** (a guaranteed loss).
* `Coherent Pr := ¬ HasDutchBook Pr`.
* `Represents Pr p` — `Pr A = ∑_{ω ∈ A} p ω`; `IsProb p` — `p ≥ 0` and
  `∑ p = 1`.

## Results (all `sorry`-free, axiom-clean)

* Easy direction `represents_isProb_coherent` — prices coming from a genuine
  probability distribution are coherent (the `p`-expected payoff is `0`, so it
  cannot be negative everywhere).
* From coherence, the probability axioms follow by explicit Dutch books:
  `Coherent.empty` (`Pr ∅ = 0`), `Coherent.univ` (`Pr univ = 1`),
  `Coherent.nonneg` (`0 ≤ Pr A`), `Coherent.le_one` (`Pr A ≤ 1`),
  `Coherent.additive` (finite additivity on disjoint events).
* `Coherent.represents_singleton` — `Pr A = ∑_{ω ∈ A} Pr {ω}` (additivity over
  singletons), whence the hard direction `coherent_exists_prob` — a coherent
  price function is represented by the probability distribution `ω ↦ Pr {ω}`.
* Headline `coherent_iff_exists_prob` — `Coherent Pr ↔ ∃ probability p,
  Represents Pr p`.
-/

open scoped BigOperators
open Finset

namespace BookProof.ChapterDutchBook

variable {Ω : Type*} [DecidableEq Ω]

/-- Indicator of an event as a real number: `1` if `ω ∈ A`, else `0`. -/
def betIndicator (A : Finset Ω) (ω : Ω) : ℝ := if ω ∈ A then 1 else 0

@[simp] lemma betIndicator_empty (ω : Ω) : betIndicator (∅ : Finset Ω) ω = 0 := by
  simp [betIndicator]

/-- Total payoff to the bettor of a finite family of gambles (events `A i`,
stakes `s i`) in state `ω`. -/
def payoff {m : ℕ} (Pr : Finset Ω → ℝ) (A : Fin m → Finset Ω) (s : Fin m → ℝ)
    (ω : Ω) : ℝ :=
  ∑ i, s i * (betIndicator (A i) ω - Pr (A i))

/-- A price function admits a **Dutch book**: a finite family of gambles whose
payoff is strictly negative in *every* state (a guaranteed loss). -/
def HasDutchBook (Pr : Finset Ω → ℝ) : Prop :=
  ∃ (m : ℕ) (A : Fin m → Finset Ω) (s : Fin m → ℝ), ∀ ω, payoff Pr A s ω < 0

/-- A price function is **coherent** if it admits no Dutch book. -/
def Coherent (Pr : Finset Ω → ℝ) : Prop := ¬ HasDutchBook Pr

/-- `p` is a probability distribution: nonnegative weights summing to `1`. -/
def IsProb [Fintype Ω] (p : Ω → ℝ) : Prop := (∀ ω, 0 ≤ p ω) ∧ ∑ ω, p ω = 1

/-- The price function `Pr` is represented by the weights `p`:
`Pr A = ∑_{ω ∈ A} p ω`. -/
def Represents (Pr : Finset Ω → ℝ) (p : Ω → ℝ) : Prop :=
  ∀ A : Finset Ω, Pr A = ∑ ω ∈ A, p ω

/-! ### Payoff of a single gamble -/

/-- The payoff of a single gamble (`m = 1`). -/
theorem payoff_single (Pr : Finset Ω → ℝ) (A₀ : Finset Ω) (s₀ : ℝ) (ω : Ω) :
    payoff Pr ![A₀] ![s₀] ω = s₀ * (betIndicator A₀ ω - Pr A₀) := by
  simp [payoff]

/-- The payoff of three combined gambles (`m = 3`). -/
theorem payoff_triple (Pr : Finset Ω → ℝ) (A₀ A₁ A₂ : Finset Ω)
    (s₀ s₁ s₂ : ℝ) (ω : Ω) :
    payoff Pr ![A₀, A₁, A₂] ![s₀, s₁, s₂] ω =
      s₀ * (betIndicator A₀ ω - Pr A₀) + s₁ * (betIndicator A₁ ω - Pr A₁)
        + s₂ * (betIndicator A₂ ω - Pr A₂) := by
  simp [payoff, Fin.sum_univ_three]

/-! ### Easy direction: probability ⇒ coherent -/

/-- **Easy direction.** If the prices are the expectations of a genuine
probability distribution `p`, then no Dutch book exists: the `p`-expected total
payoff of any finite family of gambles is exactly `0`, so the payoff cannot be
strictly negative in every state. -/
theorem represents_isProb_coherent [Fintype Ω] {Pr : Finset Ω → ℝ} {p : Ω → ℝ}
    (hp : IsProb p) (hrep : Represents Pr p) : Coherent Pr := by
  rintro ⟨m, A, s, hlt⟩
  have hbet : ∀ i, ∑ ω, p ω * betIndicator (A i) ω = Pr (A i) := by
    intro i
    rw [hrep (A i)]
    simp only [betIndicator, mul_ite, mul_one, mul_zero]
    rw [Finset.sum_ite_mem, Finset.univ_inter]
  have hE : ∑ ω, p ω * payoff Pr A s ω = 0 := by
    have hrw : ∀ ω, p ω * payoff Pr A s ω
        = ∑ i, s i * (p ω * betIndicator (A i) ω - p ω * Pr (A i)) := by
      intro ω; rw [payoff, Finset.mul_sum]; apply Finset.sum_congr rfl; intro i _; ring
    simp_rw [hrw]
    rw [Finset.sum_comm]
    apply Finset.sum_eq_zero
    intro i _
    rw [← Finset.mul_sum]
    have hz : ∑ ω, (p ω * betIndicator (A i) ω - p ω * Pr (A i)) = 0 := by
      rw [Finset.sum_sub_distrib, hbet i, ← Finset.sum_mul, hp.2, one_mul, sub_self]
    rw [hz, mul_zero]
  have hpos : ∃ ω, 0 < p ω := by
    by_contra hcon
    push_neg at hcon
    have hz : ∀ ω, p ω = 0 := fun ω => le_antisymm (hcon ω) (hp.1 ω)
    have hsum : ∑ ω, p ω = 0 := by simp [hz]
    rw [hp.2] at hsum; exact one_ne_zero hsum
  obtain ⟨ω0, hω0⟩ := hpos
  have hElt : ∑ ω, p ω * payoff Pr A s ω < ∑ _ω : Ω, (0 : ℝ) := by
    apply Finset.sum_lt_sum
    · intro ω _; exact mul_nonpos_iff.mpr (Or.inl ⟨hp.1 ω, (hlt ω).le⟩)
    · exact ⟨ω0, Finset.mem_univ _, mul_neg_of_pos_of_neg hω0 (hlt ω0)⟩
  rw [Finset.sum_const_zero, hE] at hElt
  exact lt_irrefl 0 hElt

/-! ### Hard direction: coherent ⇒ probability, via explicit Dutch books -/

/-- A coherent price function assigns `0` to the impossible event. -/
theorem Coherent.empty {Pr : Finset Ω → ℝ} (h : Coherent Pr) : Pr (∅ : Finset Ω) = 0 := by
  by_contra hne
  apply h
  refine ⟨1, ![∅], ![if 0 < Pr ∅ then 1 else -1], ?_⟩
  intro ω
  rw [payoff_single]
  rcases lt_trichotomy (Pr ∅) 0 with hlt | heq | hgt
  · rw [if_neg (by linarith)]; simp; linarith
  · exact absurd heq hne
  · rw [if_pos hgt]; simp; linarith

/-- A coherent price function assigns nonnegative prices. -/
theorem Coherent.nonneg {Pr : Finset Ω → ℝ} (h : Coherent Pr) (A : Finset Ω) :
    0 ≤ Pr A := by
  by_contra hlt
  push_neg at hlt
  apply h
  refine ⟨1, ![A], ![-1], ?_⟩
  intro ω
  rw [payoff_single]
  have hcases : betIndicator A ω = 0 ∨ betIndicator A ω = 1 := by
    unfold betIndicator; split <;> simp
  rcases hcases with h0 | h1
  · rw [h0]; simp; linarith
  · rw [h1]; simp; linarith

/-- A coherent price function assigns prices at most `1`. -/
theorem Coherent.le_one {Pr : Finset Ω → ℝ} (h : Coherent Pr) (A : Finset Ω) :
    Pr A ≤ 1 := by
  by_contra hlt
  push_neg at hlt
  apply h
  refine ⟨1, ![A], ![1], ?_⟩
  intro ω
  rw [payoff_single]
  have hcases : betIndicator A ω = 0 ∨ betIndicator A ω = 1 := by
    unfold betIndicator; split <;> simp
  rcases hcases with h0 | h1
  · rw [h0]; simp; linarith
  · rw [h1]; simp; linarith

/-- A coherent price function assigns `1` to the certain event. -/
theorem Coherent.univ [Fintype Ω] {Pr : Finset Ω → ℝ} (h : Coherent Pr) :
    Pr (Finset.univ : Finset Ω) = 1 := by
  by_contra hne
  apply h
  refine ⟨1, ![Finset.univ], ![if 1 < Pr Finset.univ then 1 else -1], ?_⟩
  intro ω
  rw [payoff_single]
  have hi : betIndicator (Finset.univ : Finset Ω) ω = 1 := by simp [betIndicator]
  rw [hi]
  rcases lt_trichotomy (Pr Finset.univ) 1 with hlt | heq | hgt
  · rw [if_neg (by linarith)]; simp; linarith
  · exact absurd heq hne
  · rw [if_pos hgt]; simp; linarith

/-- **Finite additivity.** A coherent price function is additive on disjoint
events. -/
theorem Coherent.additive {Pr : Finset Ω → ℝ} (h : Coherent Pr)
    {A B : Finset Ω} (hAB : Disjoint A B) :
    Pr (A ∪ B) = Pr A + Pr B := by
  by_contra hne
  set d := Pr (A ∪ B) - Pr A - Pr B with hd
  have hdne : d ≠ 0 := by rw [hd]; intro hc; apply hne; linarith
  apply h
  refine ⟨3, ![A, B, A ∪ B], ![if 0 < d then -1 else 1, if 0 < d then -1 else 1,
    -(if 0 < d then -1 else 1)], ?_⟩
  intro ω
  rw [payoff_triple]
  have hind : betIndicator (A ∪ B) ω = betIndicator A ω + betIndicator B ω := by
    unfold betIndicator
    by_cases ha : ω ∈ A
    · have hb : ω ∉ B := fun hb => (Finset.disjoint_left.mp hAB ha hb)
      simp [ha, hb, Finset.mem_union]
    · by_cases hb : ω ∈ B <;> simp [ha, hb, Finset.mem_union]
  rw [hind]
  set s := (if 0 < d then (-1 : ℝ) else 1) with hs
  have hexpr : s * (betIndicator A ω - Pr A) + s * (betIndicator B ω - Pr B)
      + (-s) * (betIndicator A ω + betIndicator B ω - Pr (A ∪ B)) = s * d := by
    rw [hd]; ring
  rw [hexpr]
  rcases lt_trichotomy d 0 with hlt | heq | hgt
  · rw [hs, if_neg (by linarith)]; linarith
  · exact absurd heq hdne
  · rw [hs, if_pos hgt]; nlinarith

/-- Additivity over singletons: a coherent price function is the sum of its
point prices. -/
theorem Coherent.represents_singleton {Pr : Finset Ω → ℝ} (h : Coherent Pr)
    (A : Finset Ω) : Pr A = ∑ ω ∈ A, Pr {ω} := by
  refine Finset.induction_on A ?_ ?_
  · simp [h.empty]
  · intro a s ha ih
    rw [Finset.sum_insert ha, Finset.insert_eq,
        h.additive (Finset.disjoint_singleton_left.mpr ha), ih]

/-- **Hard direction.** A coherent price function is represented by a genuine
probability distribution, namely the point prices `ω ↦ Pr {ω}`. -/
theorem coherent_exists_prob [Fintype Ω] {Pr : Finset Ω → ℝ} (h : Coherent Pr) :
    ∃ p : Ω → ℝ, IsProb p ∧ Represents Pr p := by
  refine ⟨fun ω => Pr {ω}, ⟨fun ω => h.nonneg _, ?_⟩, fun A => h.represents_singleton A⟩
  have h2 := h.represents_singleton (Finset.univ : Finset Ω)
  have h1 := h.univ
  rw [h2] at h1
  simpa using h1

/-- **de Finetti Dutch-book theorem (finite version).** A price function is
coherent iff it is the expectation functional of a probability distribution. -/
theorem coherent_iff_exists_prob [Fintype Ω] (Pr : Finset Ω → ℝ) :
    Coherent Pr ↔ ∃ p : Ω → ℝ, IsProb p ∧ Represents Pr p := by
  constructor
  · exact coherent_exists_prob
  · rintro ⟨p, hp, hrep⟩
    exact represents_isProb_coherent hp hrep

end BookProof.ChapterDutchBook

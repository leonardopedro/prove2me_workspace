import Mathlib

/-!
# Chapter — Euler's formula for a generic phase-space (the countable conditional-probability chain)

Formalization of the *countable / infinite* stick-breaking probability
distribution of `book.tex`, chapter *"Wave-function collapse versus Euler's
formula"*, §*"Euler's formula for a generic phase-space"* (`book.tex`
lines ~3565–3640).

For a **countable (possibly infinite)** partition of the phase-space the book
parametrizes the wave-function recursively as `vₙ = cₙ·lₙ + sₙ·vₙ₊₁` with
`cₙ = cos θₙ`, `sₙ = sin θₙ` and, upon collapse, obtains the classical
conditional-probability recursion.  Writing `(n or above) = {k : k ≥ n}` it
records (Equation `eq:cond`) the probability distribution as a *product of
conditional probabilities*:

> `P(n) = (∏_{k=1}^{n-1} P((k+1 or above) | (k or above))) · P(n | (n or above))`,
>   where `P(n | (n or above)) = cₙ²`,
>   `P((n+1 or above) | (n or above)) = sₙ²`, and
>   `P(n | (n or above)) + P((n+1 or above) | (n or above)) = 1`,

and remarks that *"the recursion does not need to stop"* — the parametrization is
valid in infinite dimensions.

This module formalizes the self-contained mathematical core of that infinite
chain, *independent* of any Hilbert-space or angle structure.  Let
`c : ℕ → ℝ` be the sequence of conditional probabilities
`c n = P(n | (n or above)) ∈ [0,1]` (so `1 - c n = P((n+1 or above) | (n or
above))`).  Define the *tail weight* `T N = P(N or above) = ∏_{k<N} (1 - c k)`
and the *point mass* `P n = T n · c n`.  We prove:

* `stickTail_succ` — the recursion `T (N+1) = T N · (1 - c N)`.
* `partial_sum` — the exact telescoping identity `∑_{n<N} P(n) = 1 - T N`
  (equivalently `∑_{n<N} P(n) + P(N or above) = 1`, the book's normalization).
* `stickProb_nonneg` / `stickTail_nonneg` — the weights are genuine
  probabilities when `c n ∈ [0,1]`.
* **HEADLINE `stick_hasSum_one`** / `stick_tsum_one` — if the tail weight
  `T N → 0` (the recursion "reaches every state"), the point masses sum to
  exactly `1`: `∑' n, P(n) = 1`.

We also connect the abstract chain to the book's Euler angles: with
`c n = cos²(θ n)` (`condCos`), `1 - c n = sin²(θ n)` and the point mass is
`P(n) = (∏_{k<n} sin²(θ k)) · cos²(θ n)` (`stickProb_euler`), exactly the book's
`P(n) = (∏ s_k²) c_n²`.

This complements the *finite* `n`-state result of `ChapterEulerNState` (which
shows every finite distribution is reproduced) with the *infinite* / countable
case the book emphasizes, and the *single-step* density-matrix identity of
`ChapterEulerGenericDensity`.

All results are `sorry`-free and `axiom`-clean (only `propext`,
`Classical.choice`, `Quot.sound`).
-/

open scoped BigOperators
open Filter Topology

namespace BookProof.ChapterEulerCountableChain

/-- The **tail weight** `T N = P(N or above) = ∏_{k<N} (1 - c k)`, where
`c k = P(k | (k or above))` is the `k`-th conditional probability. -/
def stickTail (c : ℕ → ℝ) (N : ℕ) : ℝ := ∏ k ∈ Finset.range N, (1 - c k)

/-- The **point mass** `P n = T n · c n = P(n or above) · P(n | (n or above))`,
the probability of outcome `n` in the book's chain. -/
def stickProb (c : ℕ → ℝ) (n : ℕ) : ℝ := stickTail c n * c n

@[simp] theorem stickTail_zero (c : ℕ → ℝ) : stickTail c 0 = 1 := by
  simp [stickTail]

/-- The tail-weight recursion `T (N+1) = T N · (1 - c N)`: peeling off the event
`(N or above) = {N} ∪ (N+1 or above)`. -/
theorem stickTail_succ (c : ℕ → ℝ) (N : ℕ) :
    stickTail c (N + 1) = stickTail c N * (1 - c N) := by
  simp [stickTail, Finset.prod_range_succ]

/-- The tail weight is non-negative when every conditional probability lies in
`[0,1]`. -/
theorem stickTail_nonneg (c : ℕ → ℝ) (hc : ∀ n, 0 ≤ c n ∧ c n ≤ 1) (N : ℕ) :
    0 ≤ stickTail c N := by
  apply Finset.prod_nonneg
  intro i _
  linarith [(hc i).2]

/-- The tail weight is at most `1` when every conditional probability lies in
`[0,1]`. -/
theorem stickTail_le_one (c : ℕ → ℝ) (hc : ∀ n, 0 ≤ c n ∧ c n ≤ 1) (N : ℕ) :
    stickTail c N ≤ 1 := by
  refine Finset.prod_le_one ?_ ?_ <;> intro i _ <;> linarith [(hc i).1, (hc i).2]

/-- Each point mass is non-negative when every conditional probability lies in
`[0,1]` — the `P(n)` are genuine (unnormalized) probabilities. -/
theorem stickProb_nonneg (c : ℕ → ℝ) (hc : ∀ n, 0 ≤ c n ∧ c n ≤ 1) (n : ℕ) :
    0 ≤ stickProb c n :=
  mul_nonneg (stickTail_nonneg c hc n) (hc n).1

/-- **Telescoping normalization (partial sums).**  The exact identity
`∑_{n<N} P(n) = 1 - T N`, i.e. `∑_{n<N} P(n) + P(N or above) = 1`.  This is the
finite truncation of the book's conditional-probability chain `eq:cond`; it holds
for *any* real sequence `c` (no positivity needed). -/
theorem partial_sum (c : ℕ → ℝ) (N : ℕ) :
    ∑ n ∈ Finset.range N, stickProb c n = 1 - stickTail c N := by
  induction N with
  | zero => simp
  | succ N ih =>
      rw [Finset.sum_range_succ, ih, stickTail_succ]
      unfold stickProb
      ring

/-- **HEADLINE — total probability is `1` in the infinite chain.**  If the tail
weight `T N = P(N or above)` tends to `0` (the recursion "reaches every state" —
the book's *"the recursion does not need to stop"*), then the point masses sum to
exactly `1`: `HasSum P 1`. -/
theorem stick_hasSum_one (c : ℕ → ℝ) (hc : ∀ n, 0 ≤ c n ∧ c n ≤ 1)
    (htail : Tendsto (stickTail c) atTop (𝓝 0)) :
    HasSum (stickProb c) 1 := by
  rw [hasSum_iff_tendsto_nat_of_nonneg (stickProb_nonneg c hc) 1]
  have heq : (fun n => ∑ i ∈ Finset.range n, stickProb c i)
      = (fun n => 1 - stickTail c n) := funext (partial_sum c)
  rw [heq]
  have h0 : Tendsto (fun n => 1 - stickTail c n) atTop (𝓝 (1 - 0)) :=
    tendsto_const_nhds.sub htail
  simpa using h0

/-- The infinite conditional-probability chain sums to `1` (tsum form). -/
theorem stick_tsum_one (c : ℕ → ℝ) (hc : ∀ n, 0 ≤ c n ∧ c n ≤ 1)
    (htail : Tendsto (stickTail c) atTop (𝓝 0)) :
    ∑' n, stickProb c n = 1 :=
  (stick_hasSum_one c hc htail).tsum_eq

/-! ## Connection to the book's Euler angles

With the conditional probabilities `c n = cos²(θ n)` the tail weights become
products of `sin²`, recovering the book's `P(n) = (∏_{k<n} s_k²) · c_n²`. -/

/-- The Euler conditional probability `c n = cos²(θ n) = P(n | (n or above))`. -/
noncomputable def condCos (θ : ℕ → ℝ) (n : ℕ) : ℝ := Real.cos (θ n) ^ 2

/-- The Euler conditional probability lies in `[0,1]`. -/
theorem condCos_mem (θ : ℕ → ℝ) (n : ℕ) : 0 ≤ condCos θ n ∧ condCos θ n ≤ 1 := by
  refine ⟨sq_nonneg _, ?_⟩
  rw [condCos]
  nlinarith [Real.sin_sq_add_cos_sq (θ n), sq_nonneg (Real.sin (θ n))]

/-- The complementary conditional probability is `1 - cos²(θ n) = sin²(θ n)`,
the book's `s_n² = P((n+1 or above) | (n or above))`. -/
theorem one_sub_condCos (θ : ℕ → ℝ) (n : ℕ) :
    1 - condCos θ n = Real.sin (θ n) ^ 2 := by
  rw [condCos]
  nlinarith [Real.sin_sq_add_cos_sq (θ n)]

/-- **The book's product formula** `P(n) = (∏_{k<n} sin²(θ k)) · cos²(θ n)`. -/
theorem stickProb_euler (θ : ℕ → ℝ) (n : ℕ) :
    stickProb (condCos θ) n
      = (∏ k ∈ Finset.range n, Real.sin (θ k) ^ 2) * Real.cos (θ n) ^ 2 := by
  unfold stickProb stickTail condCos
  congr 1
  apply Finset.prod_congr rfl
  intro k _
  have h := one_sub_condCos θ k
  rw [condCos] at h
  linarith

/-- The Euler-angle chain is a probability distribution whenever its tail weights
vanish; combines `stick_tsum_one` with `condCos_mem`. -/
theorem euler_tsum_one (θ : ℕ → ℝ)
    (htail : Tendsto (stickTail (condCos θ)) atTop (𝓝 0)) :
    ∑' n, stickProb (condCos θ) n = 1 :=
  stick_tsum_one (condCos θ) (condCos_mem θ) htail

end BookProof.ChapterEulerCountableChain

import Mathlib

/-!
# Chapter "Wave-function collapse versus Euler's formula", §"Complex and
Quaternionic Hilbert spaces" — the complex/quaternionic Born distribution is
the realification of a real one

This file formalizes the self-contained mathematical content of the subsection
*"Complex and Quaternionic Hilbert spaces"* of the chapter *"Wave-function
collapse versus Euler's formula"* (`book.tex`, §"Euler's formula for a generic
phase-space", line ~3639):

> *"While the parametrization with a real wave-function is always possible, it
> may not be the best one. … Let us consider the quaternionic case … We have a
> discrete state space defined by two real numbers `n,m`, with `1 ≤ m ≤ 4` and
> we only consider the probabilities for `n` independently of `m`,
> `P(n) = ∑_{m=1}^4 P(n,m)`. … The complex case is just the above case with
> complex numbers replacing quaternions and a state space which is the union of
> 2 identical spaces."*

The book's point is that a complex (resp. quaternionic) wave-function is the
*realification* of a real wave-function on a state space with twice (resp. four
times) as many outcomes, and the complex/quaternionic **Born probability**
`P(n) = |vₙ|²` is exactly the sum of the `2` (resp. `4`) real Born
probabilities of the underlying real coordinates:
`|z|² = (Re z)² + (Im z)²` and `|q|² = q_re² + q_i² + q_j² + q_k²`.  Because the
real Euler-angle parametrization (`ChapterEulerNState`) reproduces *any*
probability distribution, so do the complex and quaternionic ones.

This complements `ChapterEulerNState` (real case), `ChapterEulerStochastic`
(2-state), and `ChapterE3` (density-matrix Euler formula).

We model a `n`-outcome wave-function as a vector `Fin n → 𝕜` (`𝕜 = ℝ, ℂ, ℍ[ℝ]`)
and its Born distribution as `k ↦ ‖vₖ‖²`.  Everything is `sorry`-free and
`axiom`-free (only `propext`, `Classical.choice`, `Quot.sound`).

Deliverables:
* `complex_born_split` / `quat_born_split` — `P(n) = ∑_m P(n,m)` with `m` ranging
  over the `2` (resp. `4`) real coordinates;
* `complex_realification_norm` / `quat_realification_norm` — the realification
  preserves total probability (unit norm);
* `complex_reproduces` / `quat_reproduces` — every probability distribution is
  reproduced by the Born rule of a complex (resp. quaternionic) unit
  wave-function.
-/

open scoped Quaternion BigOperators

namespace BookProof.ChapterEulerComplexQuat

variable {n : ℕ}

/-! ## Complex case: state space is the union of `2` identical real spaces -/

/-- The complex Born probability of outcome `k`, `P(k) = |v k|²`. -/
noncomputable def cbornProb (v : Fin n → ℂ) (k : Fin n) : ℝ := Complex.normSq (v k)

/-- **`P(n) = ∑_{m=1}^2 P(n,m)`** (complex case): the complex Born probability is
the sum of the two real Born probabilities of its real and imaginary parts. -/
theorem complex_born_split (v : Fin n → ℂ) (k : Fin n) :
    cbornProb v k = (v k).re ^ 2 + (v k).im ^ 2 := by
  simp [cbornProb, Complex.normSq_apply]; ring

/-- The complex Born distribution is nonnegative. -/
theorem cbornProb_nonneg (v : Fin n → ℂ) (k : Fin n) : 0 ≤ cbornProb v k :=
  Complex.normSq_nonneg _

/-- The realification preserves total probability: the sum of the `2n` real
squared coordinates equals the sum of the `n` complex Born probabilities. -/
theorem complex_realification_norm (v : Fin n → ℂ) :
    ∑ k, ((v k).re ^ 2 + (v k).im ^ 2) = ∑ k, cbornProb v k := by
  refine Finset.sum_congr rfl (fun k _ => ?_)
  rw [complex_born_split]

/-- **Every probability distribution is reproduced by a complex Born rule.**
For any probability distribution `p` on `{0,…,n-1}` there is a complex unit
wave-function `v` whose complex Born probabilities equal `p`. -/
theorem complex_reproduces (p : Fin n → ℝ) (hp0 : ∀ k, 0 ≤ p k)
    (hp1 : ∑ k, p k = 1) :
    ∃ v : Fin n → ℂ, (∑ k, Complex.normSq (v k) = 1) ∧ ∀ k, cbornProb v k = p k := by
  refine ⟨fun k => (Real.sqrt (p k) : ℂ), ?_, ?_⟩
  · rw [← hp1]
    refine Finset.sum_congr rfl (fun k _ => ?_)
    rw [Complex.normSq_ofReal, Real.mul_self_sqrt (hp0 k)]
  · intro k
    rw [cbornProb, Complex.normSq_ofReal, Real.mul_self_sqrt (hp0 k)]

/-! ## Quaternionic case: state space `(n, m)` with `1 ≤ m ≤ 4` -/

/-- The quaternionic Born probability of outcome `k`, `P(k) = |v k|²`. -/
noncomputable def qbornProb (v : Fin n → ℍ[ℝ]) (k : Fin n) : ℝ := Quaternion.normSq (v k)

/-- **`P(n) = ∑_{m=1}^4 P(n,m)`** (quaternionic case): the quaternionic Born
probability is the sum of the four real Born probabilities of its real and three
imaginary components. -/
theorem quat_born_split (v : Fin n → ℍ[ℝ]) (k : Fin n) :
    qbornProb v k =
      (v k).re ^ 2 + (v k).imI ^ 2 + (v k).imJ ^ 2 + (v k).imK ^ 2 := by
  simp [qbornProb, Quaternion.normSq_def']

/-- The quaternionic Born distribution is nonnegative. -/
theorem qbornProb_nonneg (v : Fin n → ℍ[ℝ]) (k : Fin n) : 0 ≤ qbornProb v k := by
  rw [quat_born_split]; positivity

/-- The realification preserves total probability: the sum of the `4n` real
squared coordinates equals the sum of the `n` quaternionic Born probabilities. -/
theorem quat_realification_norm (v : Fin n → ℍ[ℝ]) :
    ∑ k, ((v k).re ^ 2 + (v k).imI ^ 2 + (v k).imJ ^ 2 + (v k).imK ^ 2)
      = ∑ k, qbornProb v k := by
  refine Finset.sum_congr rfl (fun k _ => ?_)
  rw [quat_born_split]

/-- **Every probability distribution is reproduced by a quaternionic Born rule.**
For any probability distribution `p` on `{0,…,n-1}` there is a quaternionic unit
wave-function `v` whose quaternionic Born probabilities equal `p`. -/
theorem quat_reproduces (p : Fin n → ℝ) (hp0 : ∀ k, 0 ≤ p k)
    (hp1 : ∑ k, p k = 1) :
    ∃ v : Fin n → ℍ[ℝ], (∑ k, Quaternion.normSq (v k) = 1) ∧ ∀ k, qbornProb v k = p k := by
  refine ⟨fun k => ((Real.sqrt (p k) : ℝ) : ℍ[ℝ]), ?_, ?_⟩
  · rw [← hp1]
    refine Finset.sum_congr rfl (fun k _ => ?_)
    have : Quaternion.normSq ((Real.sqrt (p k) : ℝ) : ℍ[ℝ]) = Real.sqrt (p k) ^ 2 := by
      simp [Quaternion.normSq_def']
    rw [this, Real.sq_sqrt (hp0 k)]
  · intro k
    have : Quaternion.normSq ((Real.sqrt (p k) : ℝ) : ℍ[ℝ]) = Real.sqrt (p k) ^ 2 := by
      simp [Quaternion.normSq_def']
    rw [qbornProb, this, Real.sq_sqrt (hp0 k)]

end BookProof.ChapterEulerComplexQuat

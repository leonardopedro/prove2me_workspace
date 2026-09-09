import Mathlib

/-!
# Chapter "Wave-function collapse versus Euler's formula", §§"Euler's formula for
a phase-space with 4 states" / "Euler's formula for a generic phase-space" — the
Born rule reproduces an arbitrary probability distribution

This file formalizes the self-contained mathematical claim of `book.tex`
(§"Euler's formula for a phase-space with 4 states", line ~3478, and its
generalization §"Euler's formula for a generic phase-space", line ~3565):

> *"any probability distribution for `n` states can be reproduced by the Born
> rule for some wave-function"*, via the Euler-angle (hyper-spherical /
> stick-breaking) parametrization
> `P(1) = c₁², P(2) = (s₁c₂)², P(3) = (s₁s₂c₃)², P(4) = (s₁s₂s₃)²`, where
> `cₙ = cos θₙ`, `sₙ = sin θₙ`, *"since for any probability `p` there is an angle
> `θₙ` such that `cₙ² = p`."*

This generalizes the 2-state result of `ChapterEulerStochastic` to `n` states.
We work with real coordinates in the book's orthonormal `l`-basis.

## Definitions

* `tailProd θ m` — the "remainder weight" `∏_{i<m} sin²(θ i)`
  (`= P(m or above)` in the book).
* `eulerWave θ n k` — the `k`-th real coordinate of the Euler wave-function
  `φ` for `n` states: `(∏_{i<k} sin θᵢ)·cos θₖ` for `k+1 < n`, and the
  cosine-free tail `∏_{i<k} sin θᵢ` for the last coordinate `k+1 = n`.
* `bornProb θ n k` — the Born probability `P(k) = |φₖ|²` of outcome `k`.

## Results

* `eulerWave_sq` — `bornProb = (eulerWave)²` (Born rule).
* `bornProb_nonneg` — every Born probability is `≥ 0`.
* `euler_sum_one` — **any** angles give a probability distribution:
  `∑_{k<n} bornProb θ n k = 1`.
* `euler_wave_unit` — the Euler wave-function is a unit vector.
* `euler_reproduces` — **headline**: for **any** probability distribution `p`
  on `{0,…,n-1}` there exist Euler angles `θ` whose Born probabilities equal
  `p`; i.e. every probability distribution is reproduced by the Born rule.
-/

open scoped BigOperators

namespace BookProof.ChapterEulerNState

/-- For any `q ∈ [0,1]` there is an angle with `cos² = q`. -/
theorem exists_cos_sq {q : ℝ} (h0 : 0 ≤ q) (h1 : q ≤ 1) :
    ∃ θ : ℝ, Real.cos θ ^ 2 = q :=
  ⟨Real.arccos (Real.sqrt q), by
    rw [Real.cos_arccos] <;> nlinarith [Real.mul_self_sqrt h0]⟩

/-- For any `q ∈ [0,1]` there is an angle with `sin² = q`. -/
theorem exists_sin_sq {q : ℝ} (h0 : 0 ≤ q) (h1 : q ≤ 1) :
    ∃ θ : ℝ, Real.sin θ ^ 2 = q := by
  obtain ⟨θ, hθ⟩ := exists_cos_sq h0 h1
  refine ⟨θ + Real.pi / 2, ?_⟩
  rw [Real.sin_add]
  simp [Real.cos_pi_div_two, Real.sin_pi_div_two]
  nlinarith [hθ]

/-- The remainder weight `∏_{i<m} sin²(θ i)` — the book's `P(m or above)`. -/
noncomputable def tailProd (θ : ℕ → ℝ) (m : ℕ) : ℝ :=
  ∏ i ∈ Finset.range m, Real.sin (θ i) ^ 2

@[simp] theorem tailProd_zero (θ : ℕ → ℝ) : tailProd θ 0 = 1 := by
  simp [tailProd]

theorem tailProd_succ (θ : ℕ → ℝ) (m : ℕ) :
    tailProd θ (m + 1) = tailProd θ m * Real.sin (θ m) ^ 2 := by
  simp [tailProd, Finset.prod_range_succ]

theorem tailProd_nonneg (θ : ℕ → ℝ) (m : ℕ) : 0 ≤ tailProd θ m :=
  Finset.prod_nonneg fun _ _ => sq_nonneg _

/-- The `k`-th real coordinate of the Euler wave-function for `n` states.
For `k + 1 < n` it carries a trailing cosine; the last coordinate (`k + 1 = n`)
is cosine-free; out of range it is `0`. -/
noncomputable def eulerWave (θ : ℕ → ℝ) (n k : ℕ) : ℝ :=
  if k + 1 < n then (∏ i ∈ Finset.range k, Real.sin (θ i)) * Real.cos (θ k)
  else if k + 1 = n then ∏ i ∈ Finset.range k, Real.sin (θ i)
  else 0

/-- The Born probability `P(k)` of outcome `k` for `n` states. -/
noncomputable def bornProb (θ : ℕ → ℝ) (n k : ℕ) : ℝ :=
  if k + 1 < n then tailProd θ k * Real.cos (θ k) ^ 2
  else if k + 1 = n then tailProd θ k
  else 0

/-- Born rule: the Born probability is the square of the wave-function coordinate. -/
theorem eulerWave_sq (θ : ℕ → ℝ) (n k : ℕ) :
    (eulerWave θ n k) ^ 2 = bornProb θ n k := by
  unfold eulerWave bornProb tailProd
  split_ifs with h1 h2
  · rw [mul_pow, ← Finset.prod_pow]
  · rw [← Finset.prod_pow]
  · ring

theorem bornProb_nonneg (θ : ℕ → ℝ) (n k : ℕ) : 0 ≤ bornProb θ n k := by
  rw [← eulerWave_sq]; exact sq_nonneg _

/-- Telescoping identity: `∑_{k<m} tailProd k · cos²(θ k) = 1 - tailProd m`. -/
theorem sum_cos_tail (θ : ℕ → ℝ) (m : ℕ) :
    ∑ k ∈ Finset.range m, tailProd θ k * Real.cos (θ k) ^ 2
      = 1 - tailProd θ m := by
  induction m with
  | zero => simp
  | succ m ih =>
    rw [Finset.sum_range_succ, ih, tailProd_succ]
    have : Real.cos (θ m) ^ 2 = 1 - Real.sin (θ m) ^ 2 := by
      have := Real.sin_sq_add_cos_sq (θ m); linarith
    rw [this]; ring

/-
**Any angles give a probability distribution**: the Born probabilities of the
Euler wave-function sum to `1`.
-/
theorem euler_sum_one (θ : ℕ → ℝ) {n : ℕ} (hn : 1 ≤ n) :
    ∑ k ∈ Finset.range n, bornProb θ n k = 1 := by
  obtain ⟨m, rfl⟩ : ∃ m, n = m + 1 := ⟨n - 1, by omega⟩
  rw [Finset.sum_range_succ]
  have hlast : bornProb θ (m + 1) m = tailProd θ m := by
    unfold bornProb; rw [if_neg (by omega), if_pos rfl]
  have hmid : ∀ k ∈ Finset.range m,
      bornProb θ (m + 1) k = tailProd θ k * Real.cos (θ k) ^ 2 := by
    intro k hk
    rw [Finset.mem_range] at hk
    unfold bornProb; rw [if_pos (by omega)]
  rw [Finset.sum_congr rfl hmid, hlast, sum_cos_tail]
  ring

/-- The Euler wave-function is a unit vector. -/
theorem euler_wave_unit (θ : ℕ → ℝ) {n : ℕ} (hn : 1 ≤ n) :
    ∑ k ∈ Finset.range n, (eulerWave θ n k) ^ 2 = 1 := by
  simp_rw [eulerWave_sq]; exact euler_sum_one θ hn

/-- The tail sum `∑_{j=k}^{n-1} p j` — the book's `P(k or above)`. -/
noncomputable def tailSum (p : ℕ → ℝ) (n k : ℕ) : ℝ :=
  ∑ j ∈ Finset.Ico k n, p j

theorem tailSum_zero_eq (p : ℕ → ℝ) (n : ℕ) :
    tailSum p n 0 = ∑ j ∈ Finset.range n, p j := by
  rw [tailSum, Finset.range_eq_Ico]

theorem tailSum_succ (p : ℕ → ℝ) (n k : ℕ) (h : k < n) :
    tailSum p n k = p k + tailSum p n (k + 1) := by
  rw [tailSum, tailSum, Finset.sum_eq_sum_Ico_succ_bot h]

theorem tailSum_last (p : ℕ → ℝ) {n : ℕ} (hn : 1 ≤ n) :
    tailSum p n (n - 1) = p (n - 1) := by
  have h : n - 1 < n := by omega
  rw [tailSum_succ p n (n - 1) h]
  have : tailSum p n ((n - 1) + 1) = 0 := by
    rw [tailSum]
    have : (n - 1) + 1 = n := by omega
    rw [this]; simp
  rw [this, add_zero]

theorem tailSum_nonneg (p : ℕ → ℝ) (hp : ∀ k, 0 ≤ p k) (n k : ℕ) :
    0 ≤ tailSum p n k :=
  Finset.sum_nonneg fun j _ => hp j

/-
The key construction: given a probability distribution `p`, there exist Euler
angles `θ` whose remainder weights `tailProd θ m` equal the tail sums
`tailSum p n m` for every `m ≤ n`.
-/
theorem exists_theta_tailProd (p : ℕ → ℝ) (hp : ∀ k, 0 ≤ p k) {n : ℕ}
    (hsum : ∑ j ∈ Finset.range n, p j = 1) :
    ∃ θ : ℕ → ℝ, ∀ m ≤ n, tailProd θ m = tailSum p n m := by
  -- For each `k < n`, pick an angle with `sin²(θ k) = tailSum(k+1)/tailSum(k)`
  -- (the conditional weight `P(k+1 or above | k or above)`).
  have h_ind : ∀ k < n, ∃ θ_k : ℝ, Real.sin θ_k ^ 2 = (tailSum p n (k + 1)) / (tailSum p n k) := by
    intro k hk
    have h_range : 0 ≤ (tailSum p n (k + 1)) / (tailSum p n k)
        ∧ (tailSum p n (k + 1)) / (tailSum p n k) ≤ 1 := by
      refine ⟨div_nonneg (tailSum_nonneg p hp n _) (tailSum_nonneg p hp n _),
        div_le_one_of_le₀ ?_ (tailSum_nonneg p hp n _)⟩
      exact Finset.sum_le_sum_of_subset_of_nonneg
        (Finset.Ico_subset_Ico (by linarith) le_rfl) fun _ _ _ => hp _
    exact exists_sin_sq h_range.1 h_range.2;
  choose! θ hθ using h_ind
  refine ⟨θ, ?_⟩
  intro m
  induction m with
  | zero => intro _; rw [tailProd_zero, tailSum_zero_eq, hsum]
  | succ m ih =>
    intro hm
    have hmn : m < n := by omega
    rw [tailProd_succ, ih hmn.le]
    by_cases h : tailSum p n m = 0
    · have h_tail : tailSum p n m = p m + tailSum p n (m + 1) := tailSum_succ p n m hmn
      have h1 : tailSum p n (m + 1) = 0 := by
        have := tailSum_nonneg p hp n (m + 1); linarith [hp m]
      rw [h, h1, zero_mul]
    · rw [hθ m hmn, mul_div_cancel₀ _ h]

/-
**Headline.** For any probability distribution `p` on `{0,…,n-1}` there exist
Euler angles `θ` whose Born probabilities equal `p`: every probability
distribution is reproduced by the Born rule.
-/
theorem euler_reproduces (p : ℕ → ℝ) (hp : ∀ k, 0 ≤ p k) {n : ℕ} (hn : 1 ≤ n)
    (hsum : ∑ j ∈ Finset.range n, p j = 1) :
    ∃ θ : ℕ → ℝ, ∀ k < n, bornProb θ n k = p k := by
  obtain ⟨ θ, hθ ⟩ := exists_theta_tailProd p hp hsum;
  refine ⟨θ, fun k hk => ?_⟩
  by_cases h : k + 1 < n;
  · convert congr_arg₂ ( · - · ) ( hθ k ( by linarith ) ) ( hθ ( k + 1 ) ( by linarith ) ) using 1;
    · unfold bornProb; simp only [h, if_true, tailProd_succ, Real.sin_sq]; ring
    · rw [ tailSum_succ _ _ _ h.le, add_sub_cancel_right ];
  · have hk1 : k + 1 = n := by omega
    have hkn : k ≤ n := by omega
    unfold bornProb
    rw [if_neg h, if_pos hk1, hθ k hkn]
    have : k = n - 1 := by omega
    rw [this, tailSum_last p hn]

end BookProof.ChapterEulerNState

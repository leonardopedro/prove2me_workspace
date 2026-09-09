import Mathlib
import BookProof.ChapterOperatorSeriesEsa

/-!
# The general quadratic Hamiltonian of a boson field with infinitely many modes

`BookProof.ChapterFullQuadraticEsa` proves that *every* real quadratic-plus-linear
Hamiltonian in **finitely many** degrees of freedom is essentially self-adjoint on the
Gauss–polynomial core.  This module removes the finiteness of the mode set: the modes are
indexed by an arbitrary type `ι`, the Hilbert space is the boson Fock space
`ℓ²(ι →₀ ℕ)` of occupation-number configurations, and the Hamiltonian is the
second-quantized quadratic expression

`H = ∑ᵢ ωᵢ aᵢ†aᵢ + ∑ₖ (gₖ a^{†Pₖ}a^{Qₖ} + conj(gₖ) a^{†Qₖ}a^{Pₖ})`,

where each interaction term `a^{†P}a^{Q}` is a product of `|P| + |Q| ≤ 2` creation and
annihilation operators — pair creation `aᵢ†aⱼ†`, pair annihilation `aⱼaᵢ`, mode exchange
`aᵢ†aⱼ`, and the linear sources `aᵢ†`, `aᵢ`.  The free dispersion `ω` is an arbitrary
non-negative function of the mode — it need not be bounded — and the interaction is an
arbitrary family, subject only to the weighted absolute summability

`∑ₖ ‖gₖ‖ (ω(Pₖ) + ω(Qₖ) + 2) < ∞`.

The route is Faris–Lavine (Nelson's commutator theorem) with the comparison operator
`N = ∑ᵢ ωᵢ aᵢ†aᵢ + 𝒩 + 1`, `𝒩` the total number operator: each elementary hop is
relatively bounded by `N` and has commutator form dominated by `N`, with constants which
are summable exactly under the hypothesis above; the series instrument
`BookProof.OperatorSeries.essentiallySelfAdjointOn_finiteModes_of_series` then applies.

## What is proved

* `deg`, `wsum`, `sig` — the total occupation number `|α|`, the free energy
  `ω(α) = ∑ᵢ ωᵢ αᵢ` and the comparison symbol `σ(α) = ω(α) + |α| + 1`.
* `fall`, `amp`, `tgt` — the falling factorial of a multi-index, the ladder amplitude of
  the monomial `a^{†P}a^{Q}` and the configuration it hops to; `amp_symm` is the
  self-adjointness of the amplitude under `(P, Q) ↦ (Q, P)`.
* `hopOp` — the elementary monomial as an operator on the maximal domain of `σ`, with
  `hopOp_norm_le` (relative bound) and `hopOp_pairing` (the adjoint relation
  `⟪a^{†P}a^{Q}x, y⟫ = ⟪x, a^{†Q}a^{P}y⟫`).
* `pairOp` — the Hermitian combination `g a^{†P}a^{Q} + conj(g) a^{†Q}a^{P}`, with its
  symmetry, its relative bound and its commutator-form bound.
* `freeOp` — the free Hamiltonian `∑ᵢ ωᵢ aᵢ†aᵢ`, symmetric, dominated by `N` and
  commuting with it.
* `fockH` and `fockH_essentiallySelfAdjointOn_core` — **the headline**: the full
  Hamiltonian is essentially self-adjoint on the finite-particle core of the Fock space.
* `bogoliubov_essentiallySelfAdjointOn_core` — the pair-creation (Bogoliubov)
  specialization.

Everything is `sorry`-free and `axiom`-free.
-/

open scoped ENNReal

namespace BookProof.FockQuadratic

open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.NavierStokesFlow.LpNat BookProof.OperatorSeries

noncomputable section

variable {ι : Type*}

/-! ## 1. Occupation-number configurations -/

/-- An occupation-number configuration: finitely many modes excited. -/
abbrev Idx (ι : Type*) := ι →₀ ℕ

/-- The total occupation number `|α| = ∑ᵢ αᵢ`. -/
def deg (a : Idx ι) : ℕ := a.sum fun _ n => n

theorem deg_add (a b : Idx ι) : deg (a + b) = deg a + deg b := by
  simp [deg, Finsupp.sum_add_index']

theorem apply_le_deg (a : Idx ι) (i : ι) : a i ≤ deg a := by
  classical
  by_cases h : i ∈ a.support
  · exact Finset.single_le_sum (f := fun j => a j) (fun _ _ => Nat.zero_le _) h
  · simp [Finsupp.notMem_support_iff.mp h]

theorem tsub_add_cancel_of_le' {P a : Idx ι} (h : P ≤ a) : a - P + P = a := by
  ext j
  have hj : P j ≤ a j := by rw [Finsupp.le_def] at h; exact h j
  simp only [Finsupp.add_apply, Finsupp.tsub_apply]
  omega

theorem deg_tsub_of_le {P a : Idx ι} (h : P ≤ a) : deg (a - P) + deg P = deg a := by
  rw [← deg_add, tsub_add_cancel_of_le' h]

/-- The free energy `ω(α) = ∑ᵢ ωᵢ αᵢ` of a configuration. -/
def wsum (ω : ι → ℝ) (a : Idx ι) : ℝ := a.sum fun i n => ω i * n

theorem wsum_add (ω : ι → ℝ) (a b : Idx ι) : wsum ω (a + b) = wsum ω a + wsum ω b := by
  simp only [wsum]
  rw [Finsupp.sum_add_index' (by intro i; simp) (by intro i m n; push_cast; ring)]

theorem wsum_nonneg {ω : ι → ℝ} (hω : ∀ i, 0 ≤ ω i) (a : Idx ι) : 0 ≤ wsum ω a :=
  Finset.sum_nonneg fun i _ => mul_nonneg (hω i) (Nat.cast_nonneg _)

theorem wsum_tsub_of_le {ω : ι → ℝ} {P a : Idx ι} (h : P ≤ a) :
    wsum ω (a - P) + wsum ω P = wsum ω a := by
  rw [← wsum_add, tsub_add_cancel_of_le' h]

/-- **The comparison symbol** `σ(α) = ω(α) + |α| + 1`: the free energy plus the total
occupation number plus one. -/
def sig (ω : ι → ℝ) (a : Idx ι) : ℝ := wsum ω a + deg a + 1

theorem sig_ge_one {ω : ι → ℝ} (hω : ∀ i, 0 ≤ ω i) (a : Idx ι) : 1 ≤ sig ω a := by
  have h1 : 0 ≤ wsum ω a := wsum_nonneg hω a
  have h2 : (0 : ℝ) ≤ deg a := Nat.cast_nonneg _
  simp only [sig]; linarith

theorem sig_nonneg {ω : ι → ℝ} (hω : ∀ i, 0 ≤ ω i) (a : Idx ι) : 0 ≤ sig ω a :=
  le_trans zero_le_one (sig_ge_one hω a)

theorem deg_add_two_le_sig {ω : ι → ℝ} (hω : ∀ i, 0 ≤ ω i) (a : Idx ι) :
    (deg a : ℝ) + 2 ≤ 2 * sig ω a := by
  have h1 : 0 ≤ wsum ω a := wsum_nonneg hω a
  have h2 : (0 : ℝ) ≤ deg a := Nat.cast_nonneg _
  simp only [sig]; linarith

/-! ## 2. Falling factorials and the ladder amplitude -/

/-- The falling factorial `n(n-1)⋯(n-p+1)`, truncated to `0` when `n < p`. -/
def fallNat (n p : ℕ) : ℕ := ∏ k ∈ Finset.range p, (n - k)

theorem fallNat_eq_zero_of_lt {n p : ℕ} (h : n < p) : fallNat n p = 0 := by
  refine Finset.prod_eq_zero (i := n) (Finset.mem_range.mpr h) ?_
  omega

theorem fallNat_le_pow (n p : ℕ) : fallNat n p ≤ n ^ p := by
  calc fallNat n p = ∏ k ∈ Finset.range p, (n - k) := rfl
    _ ≤ ∏ _k ∈ Finset.range p, n := Finset.prod_le_prod' (fun k _ => Nat.sub_le n k)
    _ = n ^ p := by simp

/-- The falling factorial of a multi-index: `α!/(α-P)!`. -/
def fall (a P : Idx ι) : ℕ := ∏ i ∈ P.support, fallNat (a i) (P i)

theorem fall_eq_zero_of_not_le {a P : Idx ι} (h : ¬ P ≤ a) : fall a P = 0 := by
  rw [Finsupp.le_def] at h
  push_neg at h
  obtain ⟨i, hi⟩ := h
  refine Finset.prod_eq_zero (i := i) ?_ (fallNat_eq_zero_of_lt hi)
  simp only [Finsupp.mem_support_iff]
  omega

theorem fall_le_pow (a P : Idx ι) : fall a P ≤ (deg a) ^ (deg P) := by
  calc fall a P = ∏ i ∈ P.support, fallNat (a i) (P i) := rfl
    _ ≤ ∏ i ∈ P.support, (a i) ^ (P i) := Finset.prod_le_prod' (fun i _ => fallNat_le_pow _ _)
    _ ≤ ∏ i ∈ P.support, (deg a) ^ (P i) :=
        Finset.prod_le_prod' (fun i _ => Nat.pow_le_pow_left (apply_le_deg a i) _)
    _ = (deg a) ^ (∑ i ∈ P.support, P i) := by rw [Finset.prod_pow_eq_pow_sum]
    _ = (deg a) ^ (deg P) := rfl

/-- The configuration reached from `α` by the monomial `a^{†P}a^{Q}`… as read on
coefficients: the coefficient of `α` in the image involves the coefficient of
`tgt P Q α = α - P + Q`. -/
def tgt (P Q a : Idx ι) : Idx ι := a - P + Q

theorem le_tgt (P Q a : Idx ι) : Q ≤ tgt P Q a := le_add_self

theorem tgt_tgt {P Q a : Idx ι} (h : P ≤ a) : tgt Q P (tgt P Q a) = a := by
  simp only [tgt, add_tsub_cancel_right]
  exact tsub_add_cancel_of_le' h

theorem deg_tgt {P Q a : Idx ι} (h : P ≤ a) : deg (tgt P Q a) + deg P = deg a + deg Q := by
  rw [tgt, deg_add, ← deg_tsub_of_le h]
  ring

theorem sig_tgt {ω : ι → ℝ} {P Q a : Idx ι} (h : P ≤ a) :
    sig ω (tgt P Q a) = sig ω a - wsum ω P - deg P + wsum ω Q + deg Q := by
  have hd : (deg (tgt P Q a) : ℝ) + deg P = deg a + deg Q := by
    exact_mod_cast congrArg (fun n : ℕ => (n : ℝ)) (deg_tgt (Q := Q) h)
  have hw : wsum ω (tgt P Q a) = wsum ω a - wsum ω P + wsum ω Q := by
    rw [tgt, wsum_add, ← wsum_tsub_of_le (ω := ω) h]
    ring
  simp only [sig, hw]
  linarith

/-- **The ladder amplitude** of the monomial `a^{†P}a^{Q}`. -/
def amp (P Q a : Idx ι) : ℝ := Real.sqrt (fall a P) * Real.sqrt (fall (tgt P Q a) Q)

theorem amp_nonneg (P Q a : Idx ι) : 0 ≤ amp P Q a :=
  mul_nonneg (Real.sqrt_nonneg _) (Real.sqrt_nonneg _)

theorem amp_eq_zero_of_not_le {P Q a : Idx ι} (h : ¬ P ≤ a) : amp P Q a = 0 := by
  simp [amp, fall_eq_zero_of_not_le h]

/-- **The amplitude is Hermitian**: the monomial `a^{†Q}a^{P}` has the same amplitude on
the hopped configuration. -/
theorem amp_symm {P Q a : Idx ι} (h : P ≤ a) : amp Q P (tgt P Q a) = amp P Q a := by
  rw [amp, amp, tgt_tgt h, mul_comm]

/-- **The amplitude of a quadratic monomial is at most `|α| + 2`.** -/
theorem amp_le_deg_add_two {P Q a : Idx ι} (hPQ : deg P + deg Q ≤ 2) :
    amp P Q a ≤ (deg a : ℝ) + 2 := by
  by_cases h : P ≤ a
  · have h3 : deg (tgt P Q a) ≤ deg a + 2 := by
      have := deg_tgt (Q := Q) h
      omega
    have hm : fall a P * fall (tgt P Q a) Q ≤ (deg a + 2) ^ 2 := by
      calc fall a P * fall (tgt P Q a) Q
          ≤ (deg a) ^ (deg P) * (deg (tgt P Q a)) ^ (deg Q) :=
            Nat.mul_le_mul (fall_le_pow a P) (fall_le_pow _ _)
        _ ≤ (deg a + 2) ^ (deg P) * (deg a + 2) ^ (deg Q) :=
            Nat.mul_le_mul (Nat.pow_le_pow_left (by omega) _) (Nat.pow_le_pow_left (by omega) _)
        _ = (deg a + 2) ^ (deg P + deg Q) := by rw [pow_add]
        _ ≤ (deg a + 2) ^ 2 := Nat.pow_le_pow_right (by omega) hPQ
    have hmR : ((fall a P : ℝ) * (fall (tgt P Q a) Q : ℝ)) ≤ ((deg a : ℝ) + 2) ^ 2 := by
      have := (Nat.cast_le (α := ℝ)).mpr hm
      push_cast at this
      linarith
    have heq : amp P Q a = Real.sqrt ((fall a P : ℝ) * (fall (tgt P Q a) Q : ℝ)) := by
      rw [amp, ← Real.sqrt_mul (by positivity)]
    rw [heq]
    calc Real.sqrt ((fall a P : ℝ) * (fall (tgt P Q a) Q : ℝ))
        ≤ Real.sqrt (((deg a : ℝ) + 2) ^ 2) := Real.sqrt_le_sqrt hmR
      _ = (deg a : ℝ) + 2 := Real.sqrt_sq (by positivity)
  · rw [amp_eq_zero_of_not_le h]
    positivity

theorem amp_le_deg_tgt_add_two {P Q a : Idx ι} (hPQ : deg P + deg Q ≤ 2) :
    amp P Q a ≤ (deg (tgt P Q a) : ℝ) + 2 := by
  by_cases h : P ≤ a
  · rw [← amp_symm h]
    exact amp_le_deg_add_two (by omega)
  · rw [amp_eq_zero_of_not_le h]
    positivity

theorem amp_le_sig {ω : ι → ℝ} (hω : ∀ i, 0 ≤ ω i) {P Q a : Idx ι} (hPQ : deg P + deg Q ≤ 2) :
    amp P Q a ≤ 2 * sig ω a :=
  le_trans (amp_le_deg_add_two hPQ) (deg_add_two_le_sig hω a)

theorem amp_le_sig_tgt {ω : ι → ℝ} (hω : ∀ i, 0 ≤ ω i) {P Q a : Idx ι}
    (hPQ : deg P + deg Q ≤ 2) : amp P Q a ≤ 2 * sig ω (tgt P Q a) :=
  le_trans (amp_le_deg_tgt_add_two hPQ) (deg_add_two_le_sig hω _)

/-! ## 3. Reindexing along a hop -/

/-- The hop `α ↦ α - P + Q` is a bijection from the configurations above `P` to the
configurations above `Q`. -/
def hopEquiv (P Q : Idx ι) : {a : Idx ι // P ≤ a} ≃ {b : Idx ι // Q ≤ b} where
  toFun a := ⟨tgt P Q a, le_tgt P Q a⟩
  invFun b := ⟨tgt Q P b, le_tgt Q P b⟩
  left_inv a := by ext1; exact tgt_tgt a.2
  right_inv b := by ext1; exact tgt_tgt b.2

/-- The hop is injective on the configurations above `P`. -/
theorem hop_injective (P Q : Idx ι) :
    Function.Injective (fun a : {a : Idx ι // P ≤ a} => tgt P Q (a : Idx ι)) := by
  intro a b hab
  have h : tgt Q P (tgt P Q (a : Idx ι)) = tgt Q P (tgt P Q (b : Idx ι)) := by
    simp only at hab
    rw [hab]
  rw [tgt_tgt a.2, tgt_tgt b.2] at h
  exact Subtype.ext h

/-- Reindexing a sum along the hop. -/
theorem tsum_hop_reindex {P Q : Idx ι} {F G : Idx ι → ℂ}
    (hF : ∀ a, ¬ P ≤ a → F a = 0) (hG : ∀ b, ¬ Q ≤ b → G b = 0)
    (hEq : ∀ a, P ≤ a → F a = G (tgt P Q a)) : ∑' a, F a = ∑' b, G b := by
  have hsF : Function.support F ⊆ {a : Idx ι | P ≤ a} := by
    intro a ha
    by_contra hc
    exact ha (hF a hc)
  have hsG : Function.support G ⊆ {b : Idx ι | Q ≤ b} := by
    intro b hb
    by_contra hc
    exact hb (hG b hc)
  have h1 : ∑' (a : {a : Idx ι // P ≤ a}), F (a : Idx ι) = ∑' a, F a :=
    tsum_subtype_eq_of_support_subset hsF
  have h2 : ∑' (b : {b : Idx ι // Q ≤ b}), G (b : Idx ι) = ∑' b, G b :=
    tsum_subtype_eq_of_support_subset hsG
  have h3 : ∑' (a : {a : Idx ι // P ≤ a}), G ((hopEquiv P Q a : {b : Idx ι // Q ≤ b}) : Idx ι)
      = ∑' (b : {b : Idx ι // Q ≤ b}), G (b : Idx ι) :=
    Equiv.tsum_eq (hopEquiv P Q) (fun b : {b : Idx ι // Q ≤ b} => G (b : Idx ι))
  rw [← h1, ← h2, ← h3]
  exact tsum_congr fun a => hEq (a : Idx ι) a.2

theorem summable_hop_comp {P Q : Idx ι} {f : Idx ι → ℝ} (hsum : Summable f)
    (F : Idx ι → ℝ) (hF0 : ∀ a, 0 ≤ F a) (hFvan : ∀ a, ¬ P ≤ a → F a = 0)
    (hFle : ∀ a, P ≤ a → F a ≤ f (tgt P Q a)) : Summable F := by
  have hsupp : Function.support F ⊆ {a : Idx ι | P ≤ a} := by
    intro a ha
    by_contra hc
    exact ha (hFvan a hc)
  have h1 : Summable (fun a : {a : Idx ι // P ≤ a} => f (tgt P Q (a : Idx ι))) :=
    hsum.comp_injective (hop_injective P Q)
  have h2 : Summable (fun a : {a : Idx ι // P ≤ a} => F (a : Idx ι)) :=
    Summable.of_nonneg_of_le (fun a => hF0 _) (fun a => hFle _ a.2) h1
  have h3 : Summable (Set.indicator {a : Idx ι | P ≤ a} F) :=
    summable_subtype_iff_indicator.mp h2
  rwa [Set.indicator_eq_self.mpr hsupp] at h3

/-- Reindexing an inequality of non-negative sums along the hop. -/
theorem tsum_hop_le {P Q : Idx ι} {f : Idx ι → ℝ} (hf : ∀ b, 0 ≤ f b) (hsum : Summable f)
    (F : Idx ι → ℝ) (hF0 : ∀ a, 0 ≤ F a) (hFvan : ∀ a, ¬ P ≤ a → F a = 0)
    (hFle : ∀ a, P ≤ a → F a ≤ f (tgt P Q a)) : ∑' a, F a ≤ ∑' b, f b := by
  have hsupp : Function.support F ⊆ {a : Idx ι | P ≤ a} := by
    intro a ha
    by_contra hc
    exact ha (hFvan a hc)
  have h1 : Summable (fun a : {a : Idx ι // P ≤ a} => f (tgt P Q (a : Idx ι))) :=
    hsum.comp_injective (hop_injective P Q)
  have h2 : Summable (fun a : {a : Idx ι // P ≤ a} => F (a : Idx ι)) :=
    Summable.of_nonneg_of_le (fun a => hF0 _) (fun a => hFle _ a.2) h1
  rw [← tsum_subtype_eq_of_support_subset hsupp]
  exact Summable.tsum_le_tsum_of_inj (fun a : {a : Idx ι // P ≤ a} => tgt P Q (a : Idx ι))
    (hop_injective P Q) (fun c _ => hf c) (fun a => hFle _ a.2) h2 hsum

/-! ## 4. The elementary monomial as an operator -/

variable {ω : ι → ℝ}

/-- The coefficientwise action of the monomial `a^{†P}a^{Q}`. -/
def hopFun (P Q : Idx ι) (x : Idx ι → ℂ) : Idx ι → ℂ :=
  fun b => (amp P Q b : ℂ) * x (tgt P Q b)

/-- The square-summability of the coefficients of an `ℓ²` state, as a `HasSum`. -/
theorem hasSum_normSq {α : Type*} (f : L2I α) :
    HasSum (fun k => ‖(f : α → ℂ) k‖ ^ 2) (‖f‖ ^ 2) := by
  have h := lp.hasSum_norm (p := 2) (E := fun _ : α => ℂ) (by norm_num) f
  have h2 : ((2 : ℝ≥0∞).toReal) = ((2 : ℕ) : ℝ) := by norm_num
  rw [h2] at h
  simpa [Real.rpow_natCast] using h

/-- The pointwise bound behind every estimate of this module: the coefficient of the
monomial at `β` is at most twice the coefficient of the comparison operator at the hopped
configuration. -/
theorem hop_pointwise (hω : ∀ i, 0 ≤ ω i) {P Q : Idx ι} (hPQ : deg P + deg Q ≤ 2)
    (x : maxDom (sig ω)) (a : Idx ι) :
    ‖hopFun P Q ((x : L2I (Idx ι)) : Idx ι → ℂ) a‖ ^ 2
      ≤ 4 * ‖((diagMax (sig ω) x : L2I (Idx ι)) : Idx ι → ℂ) (tgt P Q a)‖ ^ 2 := by
  have hamp : amp P Q a ≤ 2 * sig ω (tgt P Q a) := amp_le_sig_tgt hω hPQ
  have h0 : 0 ≤ amp P Q a := amp_nonneg _ _ _
  have hxy : ‖((diagMax (sig ω) x : L2I (Idx ι)) : Idx ι → ℂ) (tgt P Q a)‖
      = sig ω (tgt P Q a) * ‖((x : L2I (Idx ι)) : Idx ι → ℂ) (tgt P Q a)‖ := by
    simp [diagMax_coe, Complex.norm_real, Real.norm_eq_abs,
      abs_of_nonneg (sig_nonneg hω (tgt P Q a))]
  have hnorm : ‖hopFun P Q ((x : L2I (Idx ι)) : Idx ι → ℂ) a‖
      = amp P Q a * ‖((x : L2I (Idx ι)) : Idx ι → ℂ) (tgt P Q a)‖ := by
    simp [hopFun, Complex.norm_real, Real.norm_eq_abs, abs_of_nonneg h0]
  rw [hnorm, hxy]
  have hx0 : 0 ≤ ‖((x : L2I (Idx ι)) : Idx ι → ℂ) (tgt P Q a)‖ := norm_nonneg _
  have hs0 : 0 ≤ sig ω (tgt P Q a) := sig_nonneg hω _
  have hsq : amp P Q a ^ 2 ≤ (2 * sig ω (tgt P Q a)) ^ 2 := by nlinarith
  calc (amp P Q a * ‖((x : L2I (Idx ι)) : Idx ι → ℂ) (tgt P Q a)‖) ^ 2
      = amp P Q a ^ 2 * ‖((x : L2I (Idx ι)) : Idx ι → ℂ) (tgt P Q a)‖ ^ 2 := by ring
    _ ≤ (2 * sig ω (tgt P Q a)) ^ 2 * ‖((x : L2I (Idx ι)) : Idx ι → ℂ) (tgt P Q a)‖ ^ 2 := by
        exact mul_le_mul_of_nonneg_right hsq (sq_nonneg _)
    _ = 4 * (sig ω (tgt P Q a) * ‖((x : L2I (Idx ι)) : Idx ι → ℂ) (tgt P Q a)‖) ^ 2 := by ring

theorem hop_memLp (hω : ∀ i, 0 ≤ ω i) {P Q : Idx ι} (hPQ : deg P + deg Q ≤ 2)
    (x : maxDom (sig ω)) :
    Memℓp (hopFun P Q ((x : L2I (Idx ι)) : Idx ι → ℂ)) 2 := by
  refine memLpTwo_of_summable_normSq ?_
  refine summable_hop_comp (P := P) (Q := Q)
    ((summable_normSq (diagMax (sig ω) x)).mul_left 4) _ (fun a => by positivity) ?_ ?_
  · intro a ha
    simp [hopFun, amp_eq_zero_of_not_le ha]
  · intro a _
    exact hop_pointwise hω hPQ x a

/-- **The elementary monomial** `a^{†P}a^{Q}` on the maximal domain of the comparison
symbol. -/
def hopOp (hω : ∀ i, 0 ≤ ω i) (P Q : Idx ι) (hPQ : deg P + deg Q ≤ 2) :
    maxDom (sig ω) →ₗ[ℂ] L2I (Idx ι) where
  toFun x := ⟨hopFun P Q ((x : L2I (Idx ι)) : Idx ι → ℂ), hop_memLp hω hPQ x⟩
  map_add' x y := by
    refine lp.ext (funext fun b => ?_)
    simp only [hopFun, lp.coeFn_add, Pi.add_apply, Submodule.coe_add]
    ring
  map_smul' r x := by
    refine lp.ext (funext fun b => ?_)
    simp only [hopFun, lp.coeFn_smul, Pi.smul_apply, smul_eq_mul, RingHom.id_apply,
      Submodule.coe_smul]
    ring

@[simp] theorem hopOp_coe (hω : ∀ i, 0 ≤ ω i) {P Q : Idx ι} (hPQ : deg P + deg Q ≤ 2)
    (x : maxDom (sig ω)) (b : Idx ι) :
    ((hopOp hω P Q hPQ x : L2I (Idx ι)) : Idx ι → ℂ) b
      = (amp P Q b : ℂ) * ((x : L2I (Idx ι)) : Idx ι → ℂ) (tgt P Q b) := rfl

/-- **The relative bound**: the monomial is dominated by the comparison operator. -/
theorem hopOp_norm_le (hω : ∀ i, 0 ≤ ω i) {P Q : Idx ι} (hPQ : deg P + deg Q ≤ 2)
    (x : maxDom (sig ω)) :
    ‖(hopOp hω P Q hPQ x : L2I (Idx ι))‖ ≤ 2 * ‖(diagMax (sig ω) x : L2I (Idx ι))‖ := by
  have h1 := hasSum_normSq (hopOp hω P Q hPQ x : L2I (Idx ι))
  have h2 := hasSum_normSq (diagMax (sig ω) x : L2I (Idx ι))
  have hsq : ‖(hopOp hω P Q hPQ x : L2I (Idx ι))‖ ^ 2
      ≤ 4 * ‖(diagMax (sig ω) x : L2I (Idx ι))‖ ^ 2 := by
    have h4 : (4 : ℝ) * ‖(diagMax (sig ω) x : L2I (Idx ι))‖ ^ 2
        = ∑' γ, 4 * ‖((diagMax (sig ω) x : L2I (Idx ι)) : Idx ι → ℂ) γ‖ ^ 2 := by
      rw [← h2.tsum_eq, tsum_mul_left]
    rw [← h1.tsum_eq, h4]
    refine tsum_hop_le (P := P) (Q := Q) (fun b => by positivity)
      ((summable_normSq (diagMax (sig ω) x)).mul_left 4) _ (fun a => by positivity) ?_ ?_
    · intro a ha
      simp [hopOp_coe, amp_eq_zero_of_not_le ha]
    · intro a _
      exact hop_pointwise hω hPQ x a
  by_contra hc
  push_neg at hc
  nlinarith [norm_nonneg (hopOp hω P Q hPQ x : L2I (Idx ι)),
    norm_nonneg (diagMax (sig ω) x : L2I (Idx ι))]

/-- **The adjoint relation**: `a^{†Q}a^{P}` is the adjoint of `a^{†P}a^{Q}`. -/
theorem hopOp_pairing (hω : ∀ i, 0 ≤ ω i) {P Q : Idx ι} (hPQ : deg P + deg Q ≤ 2)
    (hQP : deg Q + deg P ≤ 2) (x y : maxDom (sig ω)) :
    (inner ℂ (hopOp hω P Q hPQ x : L2I (Idx ι)) (y : L2I (Idx ι)) : ℂ)
      = inner ℂ (x : L2I (Idx ι)) (hopOp hω Q P hQP y : L2I (Idx ι)) := by
  rw [lp.inner_eq_tsum, lp.inner_eq_tsum]
  refine tsum_hop_reindex (P := P) (Q := Q) ?_ ?_ ?_
  · intro b hb
    simp [RCLike.inner_apply, amp_eq_zero_of_not_le hb]
  · intro a ha
    simp [RCLike.inner_apply, amp_eq_zero_of_not_le ha]
  · intro a ha
    simp only [RCLike.inner_apply, hopOp_coe, map_mul, Complex.conj_ofReal]
    rw [amp_symm ha, tgt_tgt ha]
    ring

/-! ### The pairing symbol -/

/-- The scalar symbol `t(β) = amp(β) · conj(x(β - P + Q)) · x(β)` controlling both the
matrix element of the monomial and its commutator with the comparison operator. -/
def hopT (P Q : Idx ι) (x : Idx ι → ℂ) : Idx ι → ℂ :=
  fun b => (amp P Q b : ℂ) * (starRingEnd ℂ) (x (tgt P Q b)) * x b

theorem norm_hopT (P Q : Idx ι) (x : Idx ι → ℂ) (b : Idx ι) :
    ‖hopT P Q x b‖ = amp P Q b * ‖x (tgt P Q b)‖ * ‖x b‖ := by
  simp [hopT, Complex.norm_real, Real.norm_eq_abs, abs_of_nonneg (amp_nonneg P Q b)]

/-- **The AM–GM step**: the ladder amplitude is dominated by the comparison symbol at the
two ends of the hop. -/
theorem amp_mul_le (hω : ∀ i, 0 ≤ ω i) {P Q : Idx ι} (hPQ : deg P + deg Q ≤ 2) (b : Idx ι)
    (p r : ℝ) :
    amp P Q b * r * p ≤ sig ω b * p ^ 2 + sig ω (tgt P Q b) * r ^ 2 := by
  have h1 : amp P Q b ≤ 2 * sig ω b := amp_le_sig hω hPQ
  have h2 : amp P Q b ≤ 2 * sig ω (tgt P Q b) := amp_le_sig_tgt hω hPQ
  have h0 : 0 ≤ amp P Q b := amp_nonneg _ _ _
  have hs1 : 0 ≤ sig ω b := sig_nonneg hω _
  have hs2 : 0 ≤ sig ω (tgt P Q b) := sig_nonneg hω _
  refine le_of_sq_le_sq ?_ (by positivity)
  have hamp : amp P Q b ^ 2 ≤ 4 * (sig ω b * sig ω (tgt P Q b)) := by nlinarith
  nlinarith [sq_nonneg (sig ω b * p ^ 2 - sig ω (tgt P Q b) * r ^ 2), sq_nonneg (p * r),
    sq_nonneg p, sq_nonneg r]

/-- The comparison symbol changes by at most `ω(P) + ω(Q) + 2` along a hop. -/
theorem abs_sig_sub_sig_tgt_le (hω : ∀ i, 0 ≤ ω i) {P Q b : Idx ι} (hPQ : deg P + deg Q ≤ 2)
    (h : P ≤ b) : |sig ω b - sig ω (tgt P Q b)| ≤ wsum ω P + wsum ω Q + 2 := by
  have hst := sig_tgt (ω := ω) (P := P) (Q := Q) h
  have h1 : (0 : ℝ) ≤ wsum ω P := wsum_nonneg hω _
  have h2 : (0 : ℝ) ≤ wsum ω Q := wsum_nonneg hω _
  have h3 : (deg P : ℝ) + (deg Q : ℝ) ≤ 2 := by
    exact_mod_cast (by exact_mod_cast hPQ : deg P + deg Q ≤ 2)
  have h4 : (0 : ℝ) ≤ (deg P : ℝ) := Nat.cast_nonneg _
  have h5 : (0 : ℝ) ≤ (deg Q : ℝ) := Nat.cast_nonneg _
  rw [abs_le]
  constructor <;> [linarith; linarith]

/-! ## 5. The Hermitian interaction term -/

/-- **The Hermitian interaction term** `g a^{†P}a^{Q} + conj(g) a^{†Q}a^{P}`. -/
def pairOp (hω : ∀ i, 0 ≤ ω i) (g : ℂ) (P Q : Idx ι) (hPQ : deg P + deg Q ≤ 2) :
    maxDom (sig ω) →ₗ[ℂ] L2I (Idx ι) :=
  g • hopOp hω P Q hPQ + (starRingEnd ℂ) g • hopOp hω Q P (by omega)

theorem pairOp_symmetricOn (hω : ∀ i, 0 ≤ ω i) (g : ℂ) (P Q : Idx ι)
    (hPQ : deg P + deg Q ≤ 2) : SymmetricOn (maxDom (sig ω)) (pairOp hω g P Q hPQ) := by
  intro x y
  simp only [pairOp, LinearMap.add_apply, LinearMap.smul_apply,
    inner_add_left, inner_add_right, inner_smul_left, inner_smul_right]
  rw [hopOp_pairing hω hPQ (by omega) x y, hopOp_pairing hω (by omega : deg Q + deg P ≤ 2) hPQ x y]
  simp [RingHomCompTriple.comp_apply, RingHom.id_apply]
  ring

theorem pairOp_norm_le (hω : ∀ i, 0 ≤ ω i) (g : ℂ) (P Q : Idx ι) (hPQ : deg P + deg Q ≤ 2)
    (x : maxDom (sig ω)) :
    ‖(pairOp hω g P Q hPQ x : L2I (Idx ι))‖
      ≤ (4 * ‖g‖) * ‖(diagMax (sig ω) x : L2I (Idx ι))‖ := by
  have h1 := hopOp_norm_le hω hPQ x
  have h2 := hopOp_norm_le hω (by omega : deg Q + deg P ≤ 2) x
  have hnn : (0 : ℝ) ≤ ‖(diagMax (sig ω) x : L2I (Idx ι))‖ := norm_nonneg _
  have hcalc : ‖(pairOp hω g P Q hPQ x : L2I (Idx ι))‖
      ≤ ‖g‖ * ‖(hopOp hω P Q hPQ x : L2I (Idx ι))‖
        + ‖g‖ * ‖(hopOp hω Q P (by omega : deg Q + deg P ≤ 2) x : L2I (Idx ι))‖ := by
    simp only [pairOp, LinearMap.add_apply, LinearMap.smul_apply]
    refine le_trans (norm_add_le _ _) ?_
    simp [norm_smul]
  nlinarith [norm_nonneg g, hcalc, h1, h2]

/-- **The commutator-form bound** of the interaction term. -/
theorem pairOp_commForm_le (hω : ∀ i, 0 ≤ ω i) (g : ℂ) (P Q : Idx ι)
    (hPQ : deg P + deg Q ≤ 2) (x : maxDom (sig ω)) :
    |commForm (pairOp hω g P Q hPQ) (diagMax (sig ω)) x|
      ≤ (4 * ‖g‖ * (wsum ω P + wsum ω Q + 2)) * quadForm (diagMax (sig ω)) x := by
  classical
  have hQP : deg Q + deg P ≤ 2 := by omega
  have hc0 : ∀ b : Idx ι, 0 ≤ sig ω b := fun b => sig_nonneg hω b
  set xb : Idx ι → ℂ := ((x : L2I (Idx ι)) : Idx ι → ℂ) with hxb
  set q : ℝ := quadForm (diagMax (sig ω)) x with hqdef
  have hq0 : 0 ≤ q := diagMax_quadForm_nonneg (sig ω) hc0 x
  set W : ℝ := wsum ω P + wsum ω Q + 2 with hWdef
  have hW0 : 0 ≤ W := by
    have h1 : (0 : ℝ) ≤ wsum ω P := wsum_nonneg hω _
    have h2 : (0 : ℝ) ≤ wsum ω Q := wsum_nonneg hω _
    simp only [hWdef]; linarith
  set t : Idx ι → ℂ := hopT P Q xb with htdef
  set A : ℂ := inner ℂ (hopOp hω P Q hPQ x : L2I (Idx ι))
    (diagMax (sig ω) x : L2I (Idx ι)) with hAdef
  set B : ℂ := inner ℂ (hopOp hω Q P hQP x : L2I (Idx ι))
    (diagMax (sig ω) x : L2I (Idx ι)) with hBdef
  -- the two matrix elements as sums over the configurations above `P`
  have hA : HasSum (fun b : {b : Idx ι // P ≤ b} => (sig ω (b : Idx ι) : ℂ) * t (b : Idx ι)) A := by
    have h := lp.hasSum_inner (𝕜 := ℂ) (hopOp hω P Q hPQ x : L2I (Idx ι))
      (diagMax (sig ω) x : L2I (Idx ι))
    have hvan : ∀ b : Idx ι, b ∉ Set.range (Subtype.val : {b : Idx ι // P ≤ b} → Idx ι) →
        (inner ℂ (((hopOp hω P Q hPQ x : L2I (Idx ι)) : Idx ι → ℂ) b)
          (((diagMax (sig ω) x : L2I (Idx ι)) : Idx ι → ℂ) b) : ℂ) = 0 := by
      intro b hb
      have hnp : ¬ P ≤ b := fun hle => hb ⟨⟨b, hle⟩, rfl⟩
      simp [RCLike.inner_apply, amp_eq_zero_of_not_le hnp]
    have h2 := ((Subtype.coe_injective (p := fun b : Idx ι => P ≤ b)).hasSum_iff hvan).mpr h
    refine h2.congr_fun ?_
    intro b
    simp only [Function.comp_apply, RCLike.inner_apply, hopOp_coe, diagMax_coe, htdef, hopT,
      map_mul, Complex.conj_ofReal, hxb]
    ring
  have hB : HasSum (fun b : {b : Idx ι // P ≤ b} =>
      (sig ω (tgt P Q (b : Idx ι)) : ℂ) * (starRingEnd ℂ) (t (b : Idx ι))) B := by
    have h := lp.hasSum_inner (𝕜 := ℂ) (hopOp hω Q P hQP x : L2I (Idx ι))
      (diagMax (sig ω) x : L2I (Idx ι))
    have hvan : ∀ a : Idx ι,
        a ∉ Set.range (fun b : {b : Idx ι // P ≤ b} => tgt P Q (b : Idx ι)) →
        (inner ℂ (((hopOp hω Q P hQP x : L2I (Idx ι)) : Idx ι → ℂ) a)
          (((diagMax (sig ω) x : L2I (Idx ι)) : Idx ι → ℂ) a) : ℂ) = 0 := by
      intro a ha
      have hnq : ¬ Q ≤ a := fun hle => ha ⟨⟨tgt Q P a, le_tgt Q P a⟩, tgt_tgt hle⟩
      simp [RCLike.inner_apply, amp_eq_zero_of_not_le hnq]
    have h2 := ((hop_injective P Q).hasSum_iff hvan).mpr h
    refine h2.congr_fun ?_
    intro b
    simp only [Function.comp_apply, RCLike.inner_apply, hopOp_coe, diagMax_coe]
    rw [amp_symm b.2, tgt_tgt b.2]
    simp only [htdef, hopT, map_mul, Complex.conj_ofReal, Complex.conj_conj, hxb]
    ring
  -- the imaginary part of the matrix element of the Hermitian combination
  have hcomb : HasSum (fun b : {b : Idx ι // P ≤ b} =>
      (starRingEnd ℂ) g * ((sig ω (b : Idx ι) : ℂ) * t (b : Idx ι))
        + g * ((sig ω (tgt P Q (b : Idx ι)) : ℂ) * (starRingEnd ℂ) (t (b : Idx ι))))
      ((starRingEnd ℂ) g * A + g * B) := (hA.mul_left _).add (hB.mul_left _)
  set R : {b : Idx ι // P ≤ b} → ℝ := fun b =>
    (sig ω (b : Idx ι) - sig ω (tgt P Q (b : Idx ι))) * ((starRingEnd ℂ) g * t (b : Idx ι)).im
    with hRdef
  have him : HasSum R ((starRingEnd ℂ) g * A + g * B).im := by
    refine (Complex.hasSum_im hcomb).congr_fun ?_
    intro b
    set z : ℂ := (starRingEnd ℂ) g * t (b : Idx ι) with hz
    have hrw : (starRingEnd ℂ) g * ((sig ω (b : Idx ι) : ℂ) * t (b : Idx ι))
        + g * ((sig ω (tgt P Q (b : Idx ι)) : ℂ) * (starRingEnd ℂ) (t (b : Idx ι)))
        = (sig ω (b : Idx ι) : ℂ) * z + (sig ω (tgt P Q (b : Idx ι)) : ℂ) * (starRingEnd ℂ) z := by
      simp only [hz, map_mul, Complex.conj_conj]
      ring
    rw [hrw, Complex.add_im, Complex.im_ofReal_mul, Complex.im_ofReal_mul, Complex.conj_im, hRdef]
    ring
  -- the two halves of the comparison quadratic form
  have hquad : HasSum (fun b : Idx ι => sig ω b * ‖xb b‖ ^ 2) q :=
    diagMax_hasSum_quadForm (sig ω) x
  have hquad0 : ∀ b : Idx ι, 0 ≤ sig ω b * ‖xb b‖ ^ 2 := fun b =>
    mul_nonneg (hc0 b) (sq_nonneg _)
  have huS : Summable (fun b : {b : Idx ι // P ≤ b} =>
      sig ω (b : Idx ι) * ‖xb (b : Idx ι)‖ ^ 2) :=
    hquad.summable.subtype _
  have hvS : Summable (fun b : {b : Idx ι // P ≤ b} =>
      sig ω (tgt P Q (b : Idx ι)) * ‖xb (tgt P Q (b : Idx ι))‖ ^ 2) :=
    hquad.summable.comp_injective (hop_injective P Q)
  have huSle : (∑' b : {b : Idx ι // P ≤ b}, sig ω (b : Idx ι) * ‖xb (b : Idx ι)‖ ^ 2) ≤ q := by
    rw [← hquad.tsum_eq]
    exact Summable.tsum_le_tsum_of_inj (Subtype.val : {b : Idx ι // P ≤ b} → Idx ι)
      Subtype.coe_injective (fun c _ => hquad0 c) (fun b => le_refl _) huS hquad.summable
  have hvSle : (∑' b : {b : Idx ι // P ≤ b},
      sig ω (tgt P Q (b : Idx ι)) * ‖xb (tgt P Q (b : Idx ι))‖ ^ 2) ≤ q := by
    rw [← hquad.tsum_eq]
    exact Summable.tsum_le_tsum_of_inj (fun b : {b : Idx ι // P ≤ b} => tgt P Q (b : Idx ι))
      (hop_injective P Q) (fun c _ => hquad0 c) (fun b => le_refl _) hvS hquad.summable
  -- the pointwise bound
  have hRle : ∀ b : {b : Idx ι // P ≤ b}, |R b| ≤ (‖g‖ * W) *
      (sig ω (b : Idx ι) * ‖xb (b : Idx ι)‖ ^ 2
        + sig ω (tgt P Q (b : Idx ι)) * ‖xb (tgt P Q (b : Idx ι))‖ ^ 2) := by
    intro b
    have him1 : |((starRingEnd ℂ) g * t (b : Idx ι)).im| ≤ ‖g‖ * ‖t (b : Idx ι)‖ := by
      calc |((starRingEnd ℂ) g * t (b : Idx ι)).im|
          ≤ ‖(starRingEnd ℂ) g * t (b : Idx ι)‖ := Complex.abs_im_le_norm _
        _ = ‖g‖ * ‖t (b : Idx ι)‖ := by rw [norm_mul, RCLike.norm_conj]
    have hsig := abs_sig_sub_sig_tgt_le hω (P := P) (Q := Q) hPQ b.2
    have hnt : ‖t (b : Idx ι)‖
        = amp P Q (b : Idx ι) * ‖xb (tgt P Q (b : Idx ι))‖ * ‖xb (b : Idx ι)‖ := by
      rw [htdef]; exact norm_hopT P Q xb (b : Idx ι)
    have hamp := amp_mul_le hω (P := P) (Q := Q) hPQ (b : Idx ι)
      ‖xb (b : Idx ι)‖ ‖xb (tgt P Q (b : Idx ι))‖
    have hg0 : (0 : ℝ) ≤ ‖g‖ := norm_nonneg _
    have hnt0 : (0 : ℝ) ≤ ‖t (b : Idx ι)‖ := norm_nonneg _
    have habs : |R b| ≤ |sig ω (b : Idx ι) - sig ω (tgt P Q (b : Idx ι))|
        * |((starRingEnd ℂ) g * t (b : Idx ι)).im| := by
      rw [hRdef, abs_mul]
    have hstep : |sig ω (b : Idx ι) - sig ω (tgt P Q (b : Idx ι))|
        * |((starRingEnd ℂ) g * t (b : Idx ι)).im| ≤ W * (‖g‖ * ‖t (b : Idx ι)‖) := by
      refine mul_le_mul hsig him1 (abs_nonneg _) hW0
    have hfin : W * (‖g‖ * ‖t (b : Idx ι)‖) ≤ (‖g‖ * W) *
        (sig ω (b : Idx ι) * ‖xb (b : Idx ι)‖ ^ 2
          + sig ω (tgt P Q (b : Idx ι)) * ‖xb (tgt P Q (b : Idx ι))‖ ^ 2) := by
      rw [hnt]
      have := mul_le_mul_of_nonneg_left hamp (mul_nonneg hg0 hW0)
      nlinarith [this]
    linarith [habs, hstep, hfin]
  have habsS : Summable (fun b : {b : Idx ι // P ≤ b} => |R b|) := by
    refine Summable.of_nonneg_of_le (fun _ => abs_nonneg _) hRle ?_
    exact (huS.add hvS).mul_left _
  have hRsum : Summable R := by
    have := habsS
    exact Summable.of_norm (by simpa [Real.norm_eq_abs] using this)
  have hbound : |((starRingEnd ℂ) g * A + g * B).im| ≤ (‖g‖ * W) * (2 * q) := by
    calc |((starRingEnd ℂ) g * A + g * B).im| = |∑' b : {b : Idx ι // P ≤ b}, R b| := by
          rw [him.tsum_eq]
      _ ≤ ∑' b : {b : Idx ι // P ≤ b}, |R b| := by
          have h := norm_tsum_le_tsum_norm (f := R) (by simpa [Real.norm_eq_abs] using habsS)
          simpa [Real.norm_eq_abs] using h
      _ ≤ ∑' b : {b : Idx ι // P ≤ b}, (‖g‖ * W) *
            (sig ω (b : Idx ι) * ‖xb (b : Idx ι)‖ ^ 2
              + sig ω (tgt P Q (b : Idx ι)) * ‖xb (tgt P Q (b : Idx ι))‖ ^ 2) :=
          Summable.tsum_le_tsum hRle habsS ((huS.add hvS).mul_left _)
      _ = (‖g‖ * W) * ((∑' b : {b : Idx ι // P ≤ b}, sig ω (b : Idx ι) * ‖xb (b : Idx ι)‖ ^ 2)
            + ∑' b : {b : Idx ι // P ≤ b},
              sig ω (tgt P Q (b : Idx ι)) * ‖xb (tgt P Q (b : Idx ι))‖ ^ 2) := by
          rw [(huS.add hvS).tsum_mul_left, huS.tsum_add hvS]
      _ ≤ (‖g‖ * W) * (2 * q) := by
          have hg0 : (0 : ℝ) ≤ ‖g‖ := norm_nonneg _
          have : (0 : ℝ) ≤ ‖g‖ * W := mul_nonneg hg0 hW0
          nlinarith [huSle, hvSle]
  -- assemble
  have hinner : (inner ℂ (pairOp hω g P Q hPQ x : L2I (Idx ι))
      (diagMax (sig ω) x : L2I (Idx ι)) : ℂ) = (starRingEnd ℂ) g * A + g * B := by
    simp only [pairOp, LinearMap.add_apply, LinearMap.smul_apply, inner_add_left, inner_smul_left,
      hAdef, hBdef, Complex.conj_conj]
  rw [commForm_eq_neg_two_im, hinner, abs_mul]
  simp only [abs_neg, abs_two]
  nlinarith [hbound, hq0, norm_nonneg g, hW0]


/-! ## 6. The free Hamiltonian -/

/-- **The free Hamiltonian** `∑ᵢ ωᵢ aᵢ†aᵢ`: multiplication by the free energy. -/
def freeOp (hω : ∀ i, 0 ≤ ω i) : maxDom (sig ω) →ₗ[ℂ] L2I (Idx ι) where
  toFun x := ⟨fun b => (wsum ω b : ℂ) * ((x : L2I (Idx ι)) : Idx ι → ℂ) b, by
    refine memLpTwo_of_le (diagMax (sig ω) x) fun b => ?_
    have h1 : |wsum ω b| ≤ |sig ω b| := by
      rw [abs_of_nonneg (wsum_nonneg hω b), abs_of_nonneg (sig_nonneg hω b)]
      have h2 : (0 : ℝ) ≤ deg b := Nat.cast_nonneg _
      simp only [sig]; linarith
    simp only [diagMax_coe, norm_mul, Complex.norm_real, Real.norm_eq_abs]
    exact mul_le_mul_of_nonneg_right h1 (norm_nonneg _)⟩
  map_add' x y := by
    refine lp.ext (funext fun b => ?_)
    simp only [lp.coeFn_add, Pi.add_apply, Submodule.coe_add]
    ring
  map_smul' r x := by
    refine lp.ext (funext fun b => ?_)
    simp only [lp.coeFn_smul, Pi.smul_apply, smul_eq_mul, RingHom.id_apply, Submodule.coe_smul]
    ring

@[simp] theorem freeOp_coe (hω : ∀ i, 0 ≤ ω i) (x : maxDom (sig ω)) (b : Idx ι) :
    ((freeOp hω x : L2I (Idx ι)) : Idx ι → ℂ) b
      = (wsum ω b : ℂ) * ((x : L2I (Idx ι)) : Idx ι → ℂ) b := rfl

theorem freeOp_symmetricOn (hω : ∀ i, 0 ≤ ω i) :
    SymmetricOn (maxDom (sig ω)) (freeOp hω) := by
  intro x y
  rw [lp.inner_eq_tsum, lp.inner_eq_tsum]
  refine tsum_congr fun b => ?_
  simp only [RCLike.inner_apply, freeOp_coe, map_mul, Complex.conj_ofReal]
  ring

theorem freeOp_norm_le (hω : ∀ i, 0 ≤ ω i) (x : maxDom (sig ω)) :
    ‖(freeOp hω x : L2I (Idx ι))‖ ≤ 1 * ‖(diagMax (sig ω) x : L2I (Idx ι))‖ := by
  have h1 := hasSum_normSq (freeOp hω x : L2I (Idx ι))
  have h2 := hasSum_normSq (diagMax (sig ω) x : L2I (Idx ι))
  have hpt : ∀ b : Idx ι, ‖((freeOp hω x : L2I (Idx ι)) : Idx ι → ℂ) b‖ ^ 2
      ≤ ‖((diagMax (sig ω) x : L2I (Idx ι)) : Idx ι → ℂ) b‖ ^ 2 := by
    intro b
    have hb : |wsum ω b| ≤ |sig ω b| := by
      rw [abs_of_nonneg (wsum_nonneg hω b), abs_of_nonneg (sig_nonneg hω b)]
      have h3 : (0 : ℝ) ≤ deg b := Nat.cast_nonneg _
      simp only [sig]; linarith
    have hx : (0 : ℝ) ≤ ‖((x : L2I (Idx ι)) : Idx ι → ℂ) b‖ := norm_nonneg _
    simp only [freeOp_coe, diagMax_coe, norm_mul, Complex.norm_real, Real.norm_eq_abs]
    gcongr
  have hsq : ‖(freeOp hω x : L2I (Idx ι))‖ ^ 2 ≤ ‖(diagMax (sig ω) x : L2I (Idx ι))‖ ^ 2 := by
    rw [← h1.tsum_eq, ← h2.tsum_eq]
    exact Summable.tsum_le_tsum hpt h1.summable h2.summable
  by_contra hc
  push_neg at hc
  nlinarith [norm_nonneg (freeOp hω x : L2I (Idx ι)),
    norm_nonneg (diagMax (sig ω) x : L2I (Idx ι))]

/-- The free Hamiltonian commutes with the comparison operator. -/
theorem freeOp_commForm (hω : ∀ i, 0 ≤ ω i) (x : maxDom (sig ω)) :
    commForm (freeOp hω) (diagMax (sig ω)) x = 0 := by
  rw [commForm_eq_neg_two_im]
  have h := lp.hasSum_inner (𝕜 := ℂ) (freeOp hω x : L2I (Idx ι))
    (diagMax (sig ω) x : L2I (Idx ι))
  have him := Complex.hasSum_im h
  have hzero : ∀ b : Idx ι,
      (inner ℂ (((freeOp hω x : L2I (Idx ι)) : Idx ι → ℂ) b)
        (((diagMax (sig ω) x : L2I (Idx ι)) : Idx ι → ℂ) b) : ℂ).im = 0 := by
    intro b
    have hb : (inner ℂ (((freeOp hω x : L2I (Idx ι)) : Idx ι → ℂ) b)
        (((diagMax (sig ω) x : L2I (Idx ι)) : Idx ι → ℂ) b) : ℂ)
        = ((wsum ω b * sig ω b : ℝ) : ℂ) *
          ((starRingEnd ℂ) (((x : L2I (Idx ι)) : Idx ι → ℂ) b)
            * ((x : L2I (Idx ι)) : Idx ι → ℂ) b) := by
      simp only [RCLike.inner_apply, freeOp_coe, diagMax_coe, map_mul, Complex.conj_ofReal]
      push_cast
      ring
    have hcc : (starRingEnd ℂ) (((x : L2I (Idx ι)) : Idx ι → ℂ) b)
        * ((x : L2I (Idx ι)) : Idx ι → ℂ) b
        = ((Complex.normSq (((x : L2I (Idx ι)) : Idx ι → ℂ) b) : ℝ) : ℂ) := by
      rw [mul_comm, Complex.mul_conj]
    rw [hb, hcc, ← Complex.ofReal_mul, Complex.ofReal_im]
  have hz : HasSum (fun _ : Idx ι => (0 : ℝ))
      ((inner ℂ (freeOp hω x : L2I (Idx ι)) (diagMax (sig ω) x : L2I (Idx ι)) : ℂ).im) := by
    simpa only [hzero] using him
  rw [hz.unique hasSum_zero]
  ring

/-! ## 7. The Hamiltonian and its essential self-adjointness -/

variable {κ : Type*}

/-- **The full Hamiltonian**: free part plus the summable family of Hermitian interaction
terms. -/
def fockH (hω : ∀ i, 0 ≤ ω i) (P Q : κ → Idx ι) (g : κ → ℂ)
    (hPQ : ∀ k, deg (P k) + deg (Q k) ≤ 2)
    (hsum : Summable fun k => ‖g k‖ * (wsum ω (P k) + wsum ω (Q k) + 2)) :
    maxDom (sig ω) →ₗ[ℂ] L2I (Idx ι) :=
  freeOp hω +
    seriesOp (fun k => pairOp hω (g k) (P k) (Q k) (hPQ k)) (fun k => 4 * ‖g k‖)
      (fun k x => pairOp_norm_le hω (g k) (P k) (Q k) (hPQ k) x)
      (by
        refine Summable.of_nonneg_of_le (fun k => by positivity)
          (fun k => ?_) (hsum.mul_left 4)
        have h1 : (0 : ℝ) ≤ wsum ω (P k) := wsum_nonneg hω _
        have h2 : (0 : ℝ) ≤ wsum ω (Q k) := wsum_nonneg hω _
        have h3 : (0 : ℝ) ≤ ‖g k‖ := norm_nonneg _
        nlinarith)

/-- **Headline.**  The general quadratic Hamiltonian of a boson field with an arbitrary
mode set, an arbitrary non-negative free dispersion and an arbitrary weighted-summable
family of quadratic interaction terms is essentially self-adjoint on the finite-particle
core of the Fock space. -/
theorem fockH_essentiallySelfAdjointOn_core (hω : ∀ i, 0 ≤ ω i) (P Q : κ → Idx ι) (g : κ → ℂ)
    (hPQ : ∀ k, deg (P k) + deg (Q k) ≤ 2)
    (hsum : Summable fun k => ‖g k‖ * (wsum ω (P k) + wsum ω (Q k) + 2)) :
    EssentiallySelfAdjointOn (lpFiniteModes (Idx ι))
      ((fockH hω P Q g hPQ hsum).comp
        (Submodule.inclusion (finiteModes_le_maxDom (sig ω)))) := by
  classical
  have hc0 : ∀ b : Idx ι, 0 ≤ sig ω b := fun b => sig_nonneg hω b
  set T : κ → (maxDom (sig ω) →ₗ[ℂ] L2I (Idx ι)) :=
    fun k => pairOp hω (g k) (P k) (Q k) (hPQ k) with hT
  set A : κ → ℝ := fun k => 4 * ‖g k‖ with hAdef
  have hnorm : ∀ (k : κ) (x : maxDom (sig ω)),
      ‖(T k x : L2I (Idx ι))‖ ≤ A k * ‖(diagMax (sig ω) x : L2I (Idx ι))‖ :=
    fun k x => pairOp_norm_le hω (g k) (P k) (Q k) (hPQ k) x
  have hA : Summable A := by
    refine Summable.of_nonneg_of_le (fun k => by positivity)
      (fun k => ?_) (hsum.mul_left 4)
    have h1 : (0 : ℝ) ≤ wsum ω (P k) := wsum_nonneg hω _
    have h2 : (0 : ℝ) ≤ wsum ω (Q k) := wsum_nonneg hω _
    have h3 : (0 : ℝ) ≤ ‖g k‖ := norm_nonneg _
    nlinarith
  have hfock : fockH hω P Q g hPQ hsum = freeOp hω + seriesOp T A hnorm hA := rfl
  set B : κ → ℝ := fun k => 4 * ‖g k‖ * (wsum ω (P k) + wsum ω (Q k) + 2) with hBdef
  have hB0 : ∀ k, 0 ≤ B k := by
    intro k
    have h1 : (0 : ℝ) ≤ wsum ω (P k) := wsum_nonneg hω _
    have h2 : (0 : ℝ) ≤ wsum ω (Q k) := wsum_nonneg hω _
    have h3 : (0 : ℝ) ≤ ‖g k‖ := norm_nonneg _
    simp only [hBdef]
    positivity
  have hBsum : Summable B := by
    have := hsum.mul_left 4
    refine this.congr fun k => ?_
    simp only [hBdef]
    ring
  have hcomm : ∀ (k : κ) (x : maxDom (sig ω)),
      |commForm (T k) (diagMax (sig ω)) x| ≤ B k * quadForm (diagMax (sig ω)) x := by
    intro k x
    have h := pairOp_commForm_le hω (g k) (P k) (Q k) (hPQ k) x
    simpa [hBdef, hT, mul_assoc] using h
  rw [hfock]
  refine essentiallySelfAdjointOn_finiteModes_of_bounds (sig ω) hc0 _
    (1 + ∑' k, A k) (∑' k, B k) (tsum_nonneg hB0) ?_ ?_ ?_
  · intro x y
    have h1 := freeOp_symmetricOn hω x y
    have h2 := seriesOp_symmetricOn hnorm hA
      (fun k => pairOp_symmetricOn hω (g k) (P k) (Q k) (hPQ k)) x y
    simp only [LinearMap.add_apply, inner_add_left, inner_add_right, h1, h2]
  · intro x
    have h1 := freeOp_norm_le hω x
    have h2 := seriesOp_norm_le hnorm hA x
    have hn : (0 : ℝ) ≤ ‖(diagMax (sig ω) x : L2I (Idx ι))‖ := norm_nonneg _
    have hadd : ‖((freeOp hω + seriesOp T A hnorm hA) x : L2I (Idx ι))‖
        ≤ ‖(freeOp hω x : L2I (Idx ι))‖ + ‖(seriesOp T A hnorm hA x : L2I (Idx ι))‖ := by
      simpa only [LinearMap.add_apply] using
        norm_add_le (freeOp hω x : L2I (Idx ι)) (seriesOp T A hnorm hA x : L2I (Idx ι))
    nlinarith [hadd, h1, h2]
  · intro x
    have hq : 0 ≤ quadForm (diagMax (sig ω)) x := diagMax_quadForm_nonneg (sig ω) hc0 x
    have hsplit := commForm_add (freeOp hω) (seriesOp T A hnorm hA) (diagMax (sig ω)) x
    have hfree := freeOp_commForm hω x
    have hser := seriesOp_commForm_le hnorm hA hBsum hcomm
      (fun y => diagMax_quadForm_nonneg (sig ω) hc0 y) x
    rw [hsplit, hfree, zero_add]
    exact hser


/-! ## 8. The Bogoliubov specialization -/

/-- The pair-creation multi-index of the monomial `a†ₘ a†ₙ`. -/
def pairIdx (m n : ι) : Idx ι := Finsupp.single m 1 + Finsupp.single n 1

@[simp] theorem deg_single (i : ι) (k : ℕ) : deg (Finsupp.single i k) = k := by
  simp [deg, Finsupp.sum_single_index]

theorem wsum_single (ω : ι → ℝ) (i : ι) (k : ℕ) : wsum ω (Finsupp.single i k) = ω i * k := by
  simp [wsum, Finsupp.sum_single_index]

@[simp] theorem deg_pairIdx (m n : ι) : deg (pairIdx m n) = 2 := by
  rw [pairIdx, deg_add, deg_single, deg_single]

@[simp] theorem deg_idx_zero : deg (0 : Idx ι) = 0 := by simp [deg]

@[simp] theorem wsum_idx_zero (ω : ι → ℝ) : wsum ω (0 : Idx ι) = 0 := by simp [wsum]

theorem wsum_pairIdx (ω : ι → ℝ) (m n : ι) : wsum ω (pairIdx m n) = ω m + ω n := by
  rw [pairIdx, wsum_add, wsum_single, wsum_single]
  push_cast
  ring

/-- **The Bogoliubov Hamiltonian is essentially self-adjoint on the finite-particle
core.**  Pair creation and annihilation `gₖ a†ₘₖ a†ₙₖ + conj(gₖ) aₙₖ aₘₖ` on top of an
arbitrary non-negative free dispersion, subject only to `∑ₖ ‖gₖ‖(ωₘₖ + ωₙₖ + 2) < ∞`. -/
theorem bogoliubov_essentiallySelfAdjointOn_core (hω : ∀ i, 0 ≤ ω i) (m n : κ → ι) (g : κ → ℂ)
    (hsum : Summable fun k => ‖g k‖ * (ω (m k) + ω (n k) + 2)) :
    EssentiallySelfAdjointOn (lpFiniteModes (Idx ι))
      ((fockH hω (fun k => pairIdx (m k) (n k)) (fun _ => (0 : Idx ι)) g
          (fun k => by simp)
          (by
            refine hsum.congr fun k => ?_
            simp [wsum_pairIdx])).comp
        (Submodule.inclusion (finiteModes_le_maxDom (sig ω)))) :=
  fockH_essentiallySelfAdjointOn_core hω _ _ g _ _

end

end BookProof.FockQuadratic

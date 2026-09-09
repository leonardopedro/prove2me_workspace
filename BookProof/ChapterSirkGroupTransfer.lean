import Mathlib

/-!
# Chapter SirkGroupTransfer — the unitary-group transfer for bounded generators

`CONSOLIDATED_PLAN.md` §12.2 **Gap 3** asks for the transfer of generator
convergence to the *unitary group*: `e^{−itA_m} → e^{−itA}` strongly, locally
uniformly in `t`.  For an unbounded selected extension this is the Trotter–Kato
theorem and is still open in this development.  For **bounded** generators —
which is the case the numerics actually run in, since the reduced generator
`B_m` is an `m × m` matrix and the operator the algorithm iterates is the
*bounded* shift-invert — the transfer holds with an explicit rate, and that is
what this chapter proves.

* `norm_pow_sub_pow_le` — the telescoping estimate `‖Aⁿ − Bⁿ‖ ≤ n M^{n−1} ‖A − B‖`
  for two elements of a Banach algebra of norm at most `M`.
* `norm_exp_sub_exp_le` — summing it against the exponential series:
  `‖exp A − exp B‖ ≤ ‖A − B‖ · e^{M}`.  So the exponential is Lipschitz on balls,
  with the expected constant.
* `groupFlow`, `norm_groupFlow_sub_le` — the Schrödinger propagator
  `U_A(t) = e^{−itA}` of a bounded generator, and the transfer rate
  `‖U_A(t) − U_B(t)‖ ≤ |t| ‖A − B‖ e^{|t| M}`.
* `groupFlow_transfer_uniform_on_interval` — the **locally uniform in `t`**
  statement: on any time interval `[−T, T]` the two propagators differ by at most
  `T ‖A − B‖ e^{T M}`, uniformly, so generator convergence in norm implies
  convergence of the flows uniformly on compact time intervals.
* `groupFlow_zero` — the sanity check `U_a(0) = 1`.

## Honest boundary

This is the **bounded** half of §12.2 Gap 3.  Nothing here proves Trotter–Kato:
the unbounded case — strong *resolvent* convergence of the selected extensions
implying strong convergence of their unitary groups — needs the spectral calculus
of unbounded self-adjoint operators and remains open.  The rate proved here
degrades exponentially in `|t| M`, as it must for arbitrary bounded generators; for
*self-adjoint* generators the sharp rate `|t| ‖A − B‖` is proved in
`BookProof.ChapterBrstTruncationLeakage` (`BrstLeakage.norm_flow_sub_flow_le`), by a
Duhamel argument that uses unitarity of the two groups.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`).
-/

noncomputable section

namespace BookProof.ChapterSirkGroupTransfer

open NormedSpace

variable {A : Type*} [NormedRing A] [NormOneClass A] [NormedAlgebra ℂ A] [CompleteSpace A]

/-! ## 1. The telescoping estimate for powers -/

omit [NormedAlgebra ℂ A] [CompleteSpace A] in
theorem norm_pow_le_of_le {a : A} {M : ℝ} (ha : ‖a‖ ≤ M) (n : ℕ) : ‖a ^ n‖ ≤ M ^ n := by
  have hM : 0 ≤ M := le_trans (norm_nonneg _) ha
  induction n with
  | zero => simp
  | succ n ih =>
    calc ‖a ^ (n + 1)‖ = ‖a * a ^ n‖ := by rw [pow_succ']
      _ ≤ ‖a‖ * ‖a ^ n‖ := norm_mul_le _ _
      _ ≤ M * M ^ n := by gcongr
      _ = M ^ (n + 1) := by ring

omit [NormedAlgebra ℂ A] [CompleteSpace A] in
/-- **The telescoping estimate.**  `Aⁿ − Bⁿ = A(Aⁿ⁻¹ − Bⁿ⁻¹) + (A − B)Bⁿ⁻¹`
iterated: on the ball of radius `M` the `n`-th power map is Lipschitz with
constant `n M^{n−1}`. -/
theorem norm_pow_sub_pow_le {a b : A} {M : ℝ} (ha : ‖a‖ ≤ M) (hb : ‖b‖ ≤ M) (n : ℕ) :
    ‖a ^ (n + 1) - b ^ (n + 1)‖ ≤ (n + 1) * M ^ n * ‖a - b‖ := by
  have hM : 0 ≤ M := le_trans (norm_nonneg _) ha
  induction n with
  | zero => simp
  | succ n ih =>
    have hsplit : a ^ (n + 2) - b ^ (n + 2)
        = a * (a ^ (n + 1) - b ^ (n + 1)) + (a - b) * b ^ (n + 1) := by
      rw [pow_succ' a (n + 1), pow_succ' b (n + 1)]
      noncomm_ring
    have h1 : ‖a * (a ^ (n + 1) - b ^ (n + 1))‖ ≤ M * ((n + 1) * M ^ n * ‖a - b‖) :=
      le_trans (norm_mul_le _ _) (by gcongr)
    have h2 : ‖(a - b) * b ^ (n + 1)‖ ≤ ‖a - b‖ * M ^ (n + 1) :=
      le_trans (norm_mul_le _ _)
        (mul_le_mul_of_nonneg_left (norm_pow_le_of_le hb (n + 1)) (norm_nonneg _))
    have hstep : ((n : ℝ) + 1 + 1) * M ^ (n + 1) * ‖a - b‖
        = M * (((n : ℝ) + 1) * M ^ n * ‖a - b‖) + ‖a - b‖ * M ^ (n + 1) := by
      rw [pow_succ]; ring
    rw [hsplit]
    refine le_trans (norm_add_le _ _) ?_
    push_cast
    rw [hstep]
    exact add_le_add h1 h2

/-! ## 2. The exponential is Lipschitz on balls -/

/-- **`‖exp a − exp b‖ ≤ ‖a − b‖ e^{M}`** for `‖a‖, ‖b‖ ≤ M`: summing the
telescoping estimate against the exponential series. -/
theorem norm_exp_sub_exp_le {a b : A} {M : ℝ} (ha : ‖a‖ ≤ M) (hb : ‖b‖ ≤ M) :
    ‖exp a - exp b‖ ≤ ‖a - b‖ * Real.exp M := by
  have hM : 0 ≤ M := le_trans (norm_nonneg _) ha
  set f : ℕ → ℝ := fun n => ‖((n.factorial : ℂ))⁻¹ • (a ^ n - b ^ n)‖ with hf
  have hnormsmul : ∀ n : ℕ, f n = (n.factorial : ℝ)⁻¹ * ‖a ^ n - b ^ n‖ := by
    intro n
    simp [hf, norm_smul]
  -- the two exponential series
  have hsa := expSeries_summable' (𝕂 := ℂ) a
  have hsb := expSeries_summable' (𝕂 := ℂ) b
  have hdiff : exp a - exp b = ∑' n : ℕ, ((n.factorial : ℂ))⁻¹ • (a ^ n - b ^ n) := by
    rw [exp_eq_tsum ℂ, ← hsa.tsum_sub hsb]
    simp [smul_sub]
  -- summability of the norms
  have hfsummable : Summable f := by
    refine Summable.of_nonneg_of_le (fun n => norm_nonneg _) (fun n => ?_)
      ((Real.summable_pow_div_factorial M).mul_left 2)
    rw [hnormsmul n]
    have h1 : ‖a ^ n - b ^ n‖ ≤ M ^ n + M ^ n :=
      le_trans (norm_sub_le _ _) (add_le_add (norm_pow_le_of_le ha n) (norm_pow_le_of_le hb n))
    have h2 : (0 : ℝ) ≤ (n.factorial : ℝ)⁻¹ := by positivity
    calc (n.factorial : ℝ)⁻¹ * ‖a ^ n - b ^ n‖
        ≤ (n.factorial : ℝ)⁻¹ * (M ^ n + M ^ n) := by gcongr
      _ = 2 * (M ^ n / n.factorial) := by ring
  -- the tail bound
  have hstep : ∀ n : ℕ, f (n + 1) ≤ ‖a - b‖ * (M ^ n / n.factorial) := by
    intro n
    rw [hnormsmul (n + 1)]
    have hfac : ((n + 1).factorial : ℝ)⁻¹ * ((n : ℝ) + 1) = (n.factorial : ℝ)⁻¹ := by
      rw [Nat.factorial_succ]
      push_cast
      field_simp
    have hpos : (0 : ℝ) ≤ ((n + 1).factorial : ℝ)⁻¹ := by positivity
    calc ((n + 1).factorial : ℝ)⁻¹ * ‖a ^ (n + 1) - b ^ (n + 1)‖
        ≤ ((n + 1).factorial : ℝ)⁻¹ * (((n : ℝ) + 1) * M ^ n * ‖a - b‖) := by
          gcongr
          exact norm_pow_sub_pow_le ha hb n
      _ = (((n + 1).factorial : ℝ)⁻¹ * ((n : ℝ) + 1)) * M ^ n * ‖a - b‖ := by ring
      _ = (n.factorial : ℝ)⁻¹ * M ^ n * ‖a - b‖ := by rw [hfac]
      _ = ‖a - b‖ * (M ^ n / n.factorial) := by ring
  have hzero : f 0 = 0 := by simp [hf]
  have hexpM : ∑' n : ℕ, M ^ n / n.factorial = Real.exp M := by
    rw [Real.exp_eq_exp_ℝ, exp_eq_tsum_div]
  calc ‖exp a - exp b‖ = ‖∑' n : ℕ, ((n.factorial : ℂ))⁻¹ • (a ^ n - b ^ n)‖ := by rw [hdiff]
    _ ≤ ∑' n : ℕ, f n := norm_tsum_le_tsum_norm hfsummable
    _ = ∑' n : ℕ, f (n + 1) := by rw [hfsummable.tsum_eq_zero_add, hzero, zero_add]
    _ ≤ ∑' n : ℕ, ‖a - b‖ * (M ^ n / n.factorial) :=
        Summable.tsum_le_tsum hstep (hfsummable.comp_injective (add_left_injective 1))
          ((Real.summable_pow_div_factorial M).mul_left _)
    _ = ‖a - b‖ * Real.exp M := by rw [tsum_mul_left, hexpM]

/-! ## 3. The Schrödinger propagator of a bounded generator -/

/-- The propagator `U_a(t) = e^{−ita}` of a bounded generator. -/
def groupFlow (a : A) (t : ℝ) : A := exp ((-(t : ℂ) * Complex.I) • a)

omit [NormOneClass A] [CompleteSpace A] in
@[simp] theorem groupFlow_zero (a : A) : groupFlow a 0 = 1 := by
  simp [groupFlow]

/-- **The unitary-group transfer for bounded generators (§12.2 Gap 3, the
bounded half).**  Two bounded generators of norm at most `M` produce propagators
that differ by at most `|t| ‖a − b‖ e^{|t| M}` at time `t`. -/
theorem norm_groupFlow_sub_le {a b : A} {M : ℝ} (ha : ‖a‖ ≤ M) (hb : ‖b‖ ≤ M) (t : ℝ) :
    ‖groupFlow a t - groupFlow b t‖ ≤ |t| * ‖a - b‖ * Real.exp (|t| * M) := by
  have hM : 0 ≤ M := le_trans (norm_nonneg _) ha
  have hc : ‖(-(t : ℂ) * Complex.I)‖ = |t| := by
    simp [Complex.norm_real]
  have ha' : ‖(-(t : ℂ) * Complex.I) • a‖ ≤ |t| * M := by
    rw [norm_smul, hc]
    exact mul_le_mul_of_nonneg_left ha (abs_nonneg t)
  have hb' : ‖(-(t : ℂ) * Complex.I) • b‖ ≤ |t| * M := by
    rw [norm_smul, hc]
    exact mul_le_mul_of_nonneg_left hb (abs_nonneg t)
  have hsub : (-(t : ℂ) * Complex.I) • a - (-(t : ℂ) * Complex.I) • b
      = (-(t : ℂ) * Complex.I) • (a - b) := by
    rw [smul_sub]
  have := norm_exp_sub_exp_le ha' hb'
  rw [hsub, norm_smul, hc] at this
  simpa [groupFlow, mul_assoc] using this

/-- **Uniformity on compact time intervals.**  On `[−T, T]` the two propagators
differ by at most `T ‖a − b‖ e^{T M}`, a bound independent of `t`: generator
convergence in norm gives convergence of the flows uniformly in time on every
bounded interval. -/
theorem groupFlow_transfer_uniform_on_interval {a b : A} {M T : ℝ} (ha : ‖a‖ ≤ M)
    (hb : ‖b‖ ≤ M) (hT : 0 ≤ T) {t : ℝ} (ht : |t| ≤ T) :
    ‖groupFlow a t - groupFlow b t‖ ≤ T * ‖a - b‖ * Real.exp (T * M) := by
  have hM : 0 ≤ M := le_trans (norm_nonneg _) ha
  refine le_trans (norm_groupFlow_sub_le ha hb t) ?_
  gcongr

end BookProof.ChapterSirkGroupTransfer

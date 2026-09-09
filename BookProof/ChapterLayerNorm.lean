import Mathlib
import BookProof.ChapterAttentionRetrieval

/-!
# Chapter "The Coherent State of Attention": layer normalization fixes the gauge

Every transformer block normalizes its activations before the head reads them:
subtract the mean, divide by the standard deviation.  In the language of this
chapter that is a *gauge fixing* followed by a *temperature fixing*, and this
module proves both halves.

* `sum_layerNorm_eq_zero`, `sum_sq_layerNorm` — the normalized vector has zero mean
  and squared length exactly `d`, so it lives on a fixed sphere: the head always
  reads vectors of the same size.
* `layerNorm_add_const`, `layerNorm_smul_pos`, `layerNorm_layerNorm` — the map is
  invariant under the affine reparametrizations `x ↦ ax + c` (`a > 0`) and is
  idempotent: it is a projection onto that sphere.
* `abs_inner_layerNorm_le` — hence Cauchy–Schwarz bounds every score of a
  normalized head by `d`, so the scores have spread at most `2d` and
  `scoreSoftmax_layerNorm_ge` (via `ChapterAttentionRetrieval`) gives every key the
  guaranteed floor `e^{−2βd}/m` of attention.  **Normalization is what keeps the
  temperature of the Born measurement bounded.**

Everything here is `sorry`-free and `axiom`-free (only `propext`,
`Classical.choice`, `Quot.sound`).
-/

open scoped BigOperators

noncomputable section

namespace BookProof.ChapterLayerNorm

open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder
  BookProof.ChapterAttentionRetrieval

variable {d : ℕ}

/-! ## Mean, variance, normalization -/

/-- The mean of the coordinates. -/
def mean (x : Fin d → ℝ) : ℝ := (∑ i, x i) / d

/-- The (biased) variance of the coordinates. -/
def variance (x : Fin d → ℝ) : ℝ := (∑ i, (x i - mean x) ^ 2) / d

/-- **Layer normalization**: centre, then divide by the standard deviation. -/
def layerNorm (x : Fin d → ℝ) (i : Fin d) : ℝ := (x i - mean x) / Real.sqrt (variance x)

theorem sum_sub_mean_eq_zero (hd : 0 < d) (x : Fin d → ℝ) : ∑ i, (x i - mean x) = 0 := by
  have hd' : (d : ℝ) ≠ 0 := by positivity
  rw [Finset.sum_sub_distrib]
  simp only [Finset.sum_const, Finset.card_univ, Fintype.card_fin, nsmul_eq_mul, mean]
  field_simp
  ring

theorem variance_nonneg (x : Fin d → ℝ) : 0 ≤ variance x := by
  refine div_nonneg (Finset.sum_nonneg fun i _ => sq_nonneg _) (Nat.cast_nonneg d)

theorem sum_sq_sub_mean_eq (hd : 0 < d) (x : Fin d → ℝ) :
    ∑ i, (x i - mean x) ^ 2 = (d : ℝ) * variance x := by
  have hd' : (d : ℝ) ≠ 0 := by positivity
  rw [variance]
  field_simp

/-- The variance vanishes exactly on the constant vectors. -/
theorem variance_eq_zero_iff (hd : 0 < d) (x : Fin d → ℝ) :
    variance x = 0 ↔ ∀ i, x i = mean x := by
  have hd' : (0 : ℝ) < (d : ℝ) := by exact_mod_cast hd
  constructor
  · intro h i
    have hsum : ∑ i, (x i - mean x) ^ 2 = 0 := by
      rw [sum_sq_sub_mean_eq hd, h, mul_zero]
    have := (Finset.sum_eq_zero_iff_of_nonneg (fun j _ => sq_nonneg (x j - mean x))).mp hsum i
      (Finset.mem_univ i)
    have hz : x i - mean x = 0 := by
      exact pow_eq_zero_iff (n := 2) (by norm_num) |>.mp this
    linarith
  · intro h
    rw [variance]
    have : ∑ i, (x i - mean x) ^ 2 = 0 :=
      Finset.sum_eq_zero fun i _ => by rw [h i]; ring
    rw [this, zero_div]

/-! ## The normalized vector lives on a sphere -/

theorem sum_layerNorm_eq_zero (hd : 0 < d) (x : Fin d → ℝ) : ∑ i, layerNorm x i = 0 := by
  simp only [layerNorm, ← Finset.sum_div]
  rw [sum_sub_mean_eq_zero hd x, zero_div]

/-- The normalized vector has squared length exactly `d`. -/
theorem sum_sq_layerNorm (hd : 0 < d) {x : Fin d → ℝ} (hx : 0 < variance x) :
    ∑ i, (layerNorm x i) ^ 2 = (d : ℝ) := by
  have hs : (Real.sqrt (variance x)) ^ 2 = variance x := Real.sq_sqrt hx.le
  have hsne : variance x ≠ 0 := hx.ne'
  simp only [layerNorm, div_pow, hs, ← Finset.sum_div]
  rw [sum_sq_sub_mean_eq hd x, mul_div_assoc, div_self hsne, mul_one]

/-! ## Invariance and idempotence -/

theorem mean_add_const (hd : 0 < d) (x : Fin d → ℝ) (c : ℝ) :
    mean (fun i => x i + c) = mean x + c := by
  have hd' : (d : ℝ) ≠ 0 := by positivity
  simp only [mean, Finset.sum_add_distrib, Finset.sum_const, Finset.card_univ,
    Fintype.card_fin, nsmul_eq_mul]
  field_simp

theorem variance_add_const (hd : 0 < d) (x : Fin d → ℝ) (c : ℝ) :
    variance (fun i => x i + c) = variance x := by
  simp only [variance, mean_add_const hd x c]
  congr 1
  exact Finset.sum_congr rfl fun i _ => by ring_nf

/-- Layer normalization removes the additive gauge freedom. -/
theorem layerNorm_add_const (hd : 0 < d) (x : Fin d → ℝ) (c : ℝ) (i : Fin d) :
    layerNorm (fun i => x i + c) i = layerNorm x i := by
  simp only [layerNorm, variance_add_const hd x c, mean_add_const hd x c]
  ring_nf

theorem mean_smul (a : ℝ) (x : Fin d → ℝ) : mean (fun i => a * x i) = a * mean x := by
  simp only [mean, ← Finset.mul_sum]
  ring

theorem variance_smul (a : ℝ) (x : Fin d → ℝ) :
    variance (fun i => a * x i) = a ^ 2 * variance x := by
  have hsum : ∑ i, (a * x i - a * mean x) ^ 2 = a ^ 2 * ∑ i, (x i - mean x) ^ 2 := by
    rw [Finset.mul_sum]
    exact Finset.sum_congr rfl fun i _ => by ring
  simp only [variance, mean_smul]
  rw [hsum, mul_div_assoc]

/-- Layer normalization removes the multiplicative gauge freedom. -/
theorem layerNorm_smul_pos {a : ℝ} (ha : 0 < a) (x : Fin d → ℝ) (i : Fin d) :
    layerNorm (fun i => a * x i) i = layerNorm x i := by
  have hsqrt : Real.sqrt (a ^ 2 * variance x) = a * Real.sqrt (variance x) := by
    rw [Real.sqrt_mul (sq_nonneg a), Real.sqrt_sq ha.le]
  simp only [layerNorm, variance_smul, mean_smul, hsqrt]
  rw [← mul_sub, mul_div_mul_left _ _ ha.ne']

theorem mean_layerNorm (hd : 0 < d) (x : Fin d → ℝ) : mean (layerNorm x) = 0 := by
  have hd' : (d : ℝ) ≠ 0 := by positivity
  rw [mean, sum_layerNorm_eq_zero hd x, zero_div]

theorem variance_layerNorm (hd : 0 < d) {x : Fin d → ℝ} (hx : 0 < variance x) :
    variance (layerNorm x) = 1 := by
  have hd' : (d : ℝ) ≠ 0 := by positivity
  rw [variance, mean_layerNorm hd x]
  simp only [sub_zero]
  rw [sum_sq_layerNorm hd hx, div_self hd']

/-- **Layer normalization is a projection**: normalizing twice is normalizing once. -/
theorem layerNorm_layerNorm (hd : 0 < d) {x : Fin d → ℝ} (hx : 0 < variance x) (i : Fin d) :
    layerNorm (layerNorm x) i = layerNorm x i := by
  rw [layerNorm, mean_layerNorm hd x, variance_layerNorm hd hx]
  simp

/-! ## Bounded scores, bounded temperature -/

/-- **Cauchy–Schwarz for normalized activations**: every score of a layer-normalized
head is bounded by the head dimension. -/
theorem abs_inner_layerNorm_le (hd : 0 < d) {x y : Fin d → ℝ} (hx : 0 < variance x)
    (hy : 0 < variance y) :
    |∑ i, layerNorm x i * layerNorm y i| ≤ (d : ℝ) := by
  have hcs : (∑ i, layerNorm x i * layerNorm y i) ^ 2
      ≤ (∑ i, (layerNorm x i) ^ 2) * (∑ i, (layerNorm y i) ^ 2) :=
    Finset.sum_mul_sq_le_sq_mul_sq _ _ _
  rw [sum_sq_layerNorm hd hx, sum_sq_layerNorm hd hy] at hcs
  have hd' : (0 : ℝ) ≤ (d : ℝ) := Nat.cast_nonneg d
  nlinarith [abs_nonneg (∑ i, layerNorm x i * layerNorm y i),
    sq_abs (∑ i, layerNorm x i * layerNorm y i)]

/-- **Normalization keeps the temperature bounded.**  With layer-normalized queries
and keys the scores span at most `2d`, so at inverse temperature `β ≥ 0` every key
keeps at least `e^{−2βd}/m` of the attention: a normalized head can never collapse
completely onto one key. -/
theorem scoreSoftmax_layerNorm_ge {m : ℕ} {beta : ℝ} (hb : 0 ≤ beta) (hd : 0 < d)
    {q : Fin d → ℝ} {k : Fin m → (Fin d → ℝ)} (hq : 0 < variance q)
    (hk : ∀ j, 0 < variance (k j)) (j : Fin m) :
    Real.exp (-(beta * (2 * d))) / (m : ℝ)
      ≤ scoreSoftmax beta (fun l => ∑ i, layerNorm q i * layerNorm (k l) i) j := by
  refine scoreSoftmax_ge_of_spread hb _ j fun l => ?_
  have h1 := abs_inner_layerNorm_le hd hq (hk l)
  have h2 := abs_inner_layerNorm_le hd hq (hk j)
  have h1' := abs_le.mp h1
  have h2' := abs_le.mp h2
  linarith [h1'.2, h2'.1]

end BookProof.ChapterLayerNorm

end

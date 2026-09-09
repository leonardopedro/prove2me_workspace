import Mathlib
import BookProof.ChapterSoftmaxSharpness

/-!
# Chapter "The Coherent State of Attention": why the scores are divided by `√d`

Attention scores are dot products of `d`-dimensional vectors, and the standard
head divides them by `√d` before the Softmax.  The reason is a scaling law, and
this module proves it.

Take the query to be a random sign pattern `q ∈ {±1}^d` (the uniform Rademacher
model of "an unstructured query") and a fixed key `k`.  Then

* `rademacherMean_dot` — the raw score `⟨q,k⟩` has mean `0`, and
* `rademacherMean_dot_sq` — mean square `∑ᵢ kᵢ²`, i.e. `‖k‖²`.

So for a key with unit-size entries the score has root-mean-square `√d`
(`rademacherMean_dot_sq_of_unit_entries`): **the raw dot product grows like `√d`**.
Since `scoreSoftmax_div` shows that dividing every score by `c > 0` is exactly
dividing the inverse temperature by `c`, feeding raw scores to a Softmax at fixed
`β` is feeding scaled scores at the inverse temperature `β√d`, which diverges with
the model width — the head would freeze onto its arg-max as `d` grows.  Dividing
by `√d` (`rademacherMean_scaledDot_sq_of_unit_entries`: mean square exactly `1`)
holds the temperature fixed instead.

Everything here is `sorry`-free and `axiom`-free (only `propext`,
`Classical.choice`, `Quot.sound`).
-/

open scoped BigOperators

noncomputable section

namespace BookProof.ChapterScaledDotProduct

open BookProof.ChapterSoftmaxSharpness

variable {d : ℕ}

/-! ## The Rademacher model -/

/-- The sign attached to a bit. -/
def sgn (b : Bool) : ℝ := if b then 1 else -1

theorem sgn_not (b : Bool) : sgn (!b) = -sgn b := by
  cases b <;> simp [sgn]

theorem sgn_mul_self (b : Bool) : sgn b * sgn b = 1 := by
  cases b <;> norm_num [sgn]

/-- The sign vector of a bit pattern: an unstructured `±1` query. -/
def signVec (x : Fin d → Bool) (i : Fin d) : ℝ := sgn (x i)

/-- The average of `f` over the `2^d` sign patterns. -/
def rademacherMean (f : (Fin d → Bool) → ℝ) : ℝ :=
  (∑ x : (Fin d → Bool), f x) / 2 ^ d

/-- The dot product of two coordinate vectors. -/
def dot (u v : Fin d → ℝ) : ℝ := ∑ i, u i * v i

theorem card_signPatterns : Fintype.card (Fin d → Bool) = 2 ^ d := by
  simp

/-! ## Flipping one coordinate -/

/-- Flipping the `i`-th bit. -/
def flipAt (i : Fin d) (x : Fin d → Bool) : Fin d → Bool := Function.update x i (!(x i))

theorem flipAt_involutive (i : Fin d) : Function.Involutive (flipAt (d := d) i) := by
  intro x
  funext j
  by_cases h : j = i
  · subst h; simp [flipAt]
  · simp [flipAt, Function.update_of_ne h]

/-- Flipping the `i`-th bit as a permutation of the sign patterns. -/
def flipEquiv (i : Fin d) : (Fin d → Bool) ≃ (Fin d → Bool) :=
  (flipAt_involutive i).toPerm _

theorem flipEquiv_apply_self (i : Fin d) (x : Fin d → Bool) :
    (flipEquiv i x) i = !(x i) := by
  simp [flipEquiv, flipAt]

theorem flipEquiv_apply_of_ne {i j : Fin d} (h : j ≠ i) (x : Fin d → Bool) :
    (flipEquiv i x) j = x j := by
  simp [flipEquiv, flipAt, Function.update_of_ne h]

/-- A single coordinate sign averages to zero. -/
theorem sum_sgn_eq_zero (i : Fin d) : ∑ x : (Fin d → Bool), sgn (x i) = 0 := by
  have h : ∑ x : (Fin d → Bool), sgn ((flipEquiv i x) i)
      = ∑ x : (Fin d → Bool), sgn (x i) :=
    Equiv.sum_comp (flipEquiv i) (fun x => sgn (x i))
  have h2 : ∑ x : (Fin d → Bool), sgn ((flipEquiv i x) i)
      = -∑ x : (Fin d → Bool), sgn (x i) := by
    rw [← Finset.sum_neg_distrib]
    exact Finset.sum_congr rfl fun x _ => by
      rw [flipEquiv_apply_self, sgn_not]
  linarith [h.symm.trans h2]

/-- Two distinct coordinate signs are uncorrelated. -/
theorem sum_sgn_mul_eq_zero {i j : Fin d} (hij : i ≠ j) :
    ∑ x : (Fin d → Bool), sgn (x i) * sgn (x j) = 0 := by
  have h : ∑ x : (Fin d → Bool), sgn ((flipEquiv i x) i) * sgn ((flipEquiv i x) j)
      = ∑ x : (Fin d → Bool), sgn (x i) * sgn (x j) :=
    Equiv.sum_comp (flipEquiv i) (fun x => sgn (x i) * sgn (x j))
  have h2 : ∑ x : (Fin d → Bool), sgn ((flipEquiv i x) i) * sgn ((flipEquiv i x) j)
      = -∑ x : (Fin d → Bool), sgn (x i) * sgn (x j) := by
    rw [← Finset.sum_neg_distrib]
    refine Finset.sum_congr rfl fun x _ => ?_
    rw [flipEquiv_apply_self, flipEquiv_apply_of_ne (Ne.symm hij), sgn_not]
    ring
  linarith [h.symm.trans h2]

theorem sum_sgn_mul_self (i : Fin d) :
    ∑ x : (Fin d → Bool), sgn (x i) * sgn (x i) = 2 ^ d := by
  rw [Finset.sum_congr rfl fun x (_ : x ∈ Finset.univ) => sgn_mul_self (x i)]
  simp

/-! ## The mean and the mean square of a raw score -/

theorem two_pow_ne_zero' : (2 : ℝ) ^ d ≠ 0 := by positivity

/-- **The raw attention score of an unstructured query has mean zero.** -/
theorem rademacherMean_dot (k : Fin d → ℝ) :
    rademacherMean (fun x => dot (signVec x) k) = 0 := by
  have hswap : ∑ x : (Fin d → Bool), dot (signVec x) k
      = ∑ i, (∑ x : (Fin d → Bool), sgn (x i)) * k i := by
    simp only [dot, signVec, Finset.sum_mul]
    rw [Finset.sum_comm]
  rw [rademacherMean, hswap]
  simp [sum_sgn_eq_zero]

/-- **The raw attention score has mean square `‖k‖²`.**  Its root-mean-square is
therefore `‖k‖`, which for a key with unit-size entries is `√d`. -/
theorem rademacherMean_dot_sq (k : Fin d → ℝ) :
    rademacherMean (fun x => (dot (signVec x) k) ^ 2) = ∑ i, (k i) ^ 2 := by
  have hexp : ∀ x : (Fin d → Bool), (dot (signVec x) k) ^ 2
      = ∑ i, ∑ j, (sgn (x i) * sgn (x j)) * (k i * k j) := by
    intro x
    rw [sq, dot, Finset.sum_mul_sum]
    exact Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun j _ => by
      simp only [signVec]; ring
  have hswap : ∑ x : (Fin d → Bool), (dot (signVec x) k) ^ 2
      = ∑ i, ∑ j, (∑ x : (Fin d → Bool), sgn (x i) * sgn (x j)) * (k i * k j) := by
    rw [Finset.sum_congr rfl fun x (_ : x ∈ Finset.univ) => hexp x]
    rw [Finset.sum_comm]
    refine Finset.sum_congr rfl fun i _ => ?_
    rw [Finset.sum_comm]
    exact Finset.sum_congr rfl fun j _ => by rw [Finset.sum_mul]
  have hinner : ∀ i : Fin d,
      ∑ j, (∑ x : (Fin d → Bool), sgn (x i) * sgn (x j)) * (k i * k j)
        = (2 : ℝ) ^ d * (k i) ^ 2 := by
    intro i
    rw [Finset.sum_eq_single i]
    · rw [sum_sgn_mul_self]; ring
    · intro j _ hj
      rw [sum_sgn_mul_eq_zero (Ne.symm hj), zero_mul]
    · intro hi
      exact absurd (Finset.mem_univ i) hi
  rw [rademacherMean, hswap, Finset.sum_congr rfl fun i (_ : i ∈ Finset.univ) => hinner i,
    ← Finset.mul_sum, mul_comm, mul_div_assoc, div_self two_pow_ne_zero', mul_one]

/-- For a key whose entries are all `±1`, the raw score has mean square `d`. -/
theorem rademacherMean_dot_sq_of_unit_entries {k : Fin d → ℝ} (hk : ∀ i, (k i) ^ 2 = 1) :
    rademacherMean (fun x => (dot (signVec x) k) ^ 2) = (d : ℝ) := by
  rw [rademacherMean_dot_sq, Finset.sum_congr rfl fun i (_ : i ∈ Finset.univ) => hk i]
  simp

/-! ## The `1/√d` rescaling -/

/-- The scaled dot-product score of the standard attention head. -/
def scaledDot (u v : Fin d → ℝ) : ℝ := dot u v / Real.sqrt d

/-- **The scaled score has mean square `1`**, independently of the width `d`: this
is exactly what the `1/√d` of scaled dot-product attention buys. -/
theorem rademacherMean_scaledDot_sq_of_unit_entries (hd : 0 < d) {k : Fin d → ℝ}
    (hk : ∀ i, (k i) ^ 2 = 1) :
    rademacherMean (fun x => (scaledDot (signVec x) k) ^ 2) = 1 := by
  have hdpos : (0 : ℝ) < (d : ℝ) := by exact_mod_cast hd
  have hs : Real.sqrt d ≠ 0 := by positivity
  have hsq : (Real.sqrt d) ^ 2 = (d : ℝ) := Real.sq_sqrt hdpos.le
  have hrw : ∀ x : (Fin d → Bool), (scaledDot (signVec x) k) ^ 2
      = (dot (signVec x) k) ^ 2 / (d : ℝ) := by
    intro x
    rw [scaledDot, div_pow, hsq]
  have hsum : ∑ x : (Fin d → Bool), (scaledDot (signVec x) k) ^ 2
      = (∑ x : (Fin d → Bool), (dot (signVec x) k) ^ 2) / (d : ℝ) := by
    rw [Finset.sum_congr rfl fun x (_ : x ∈ Finset.univ) => hrw x, Finset.sum_div]
  have hmean := rademacherMean_dot_sq_of_unit_entries hk
  rw [rademacherMean] at hmean ⊢
  rw [hsum, div_div, mul_comm, ← div_div, hmean]
  field_simp

/-! ## Rescaling the scores is rescaling the temperature -/

variable {m : ℕ}

/-- Dividing every score by `c` is dividing the inverse temperature by `c`. -/
theorem scoreSoftmax_div (beta c : ℝ) (s : Fin m → ℝ) (j : Fin m) :
    scoreSoftmax beta (fun l => s l / c) j = scoreSoftmax (beta / c) s j := by
  simp only [scoreSoftmax, mul_div_assoc, div_mul_eq_mul_div]

/-- **The unscaled head runs at inverse temperature `β√d`.**  Feeding raw dot
products to the Softmax at inverse temperature `β` is the same as feeding the
scaled scores at `β√d`, so at fixed `β` the head sharpens without bound as the
width grows; the `1/√d` of scaled dot-product attention is what keeps the
temperature fixed. -/
theorem scoreSoftmax_scaled (beta : ℝ) (s : Fin m → ℝ) (j : Fin m) :
    scoreSoftmax beta (fun l => s l / Real.sqrt d) j
      = scoreSoftmax (beta / Real.sqrt d) s j :=
  scoreSoftmax_div beta (Real.sqrt d) s j

end BookProof.ChapterScaledDotProduct

end

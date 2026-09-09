import Mathlib
import BookProof.ChapterLorentzGroup

/-!
# Chapter "Real representations, CPT theorem …", §"On the Lorentz, SL(2,C) and Pin(3,1) groups":
the proper orthochronous Lorentz group `SO⁺(1,3)` as a normal subgroup of `O(1,3)`

This file continues Wave 78 (`ChapterLorentzGroup.lean`, Note 43) with the next
self-contained claim of the same **Note 43** (`book.tex` line ~5366):

> The proper orthochronous Lorentz subgroup is defined by
> `SO⁺(1,3) ≡ {λ ∈ O(1,3) : det(λ) = 1, λ⁰₀ > 0}`. It is a normal subgroup.

Everything here uses **only** the Minkowski metric `η = diag(1,-1,-1,-1)` and the
group `O(1,3)` from `BookProof.LorentzGroup`; there are no gamma / Majorana
matrices (staying off both the gravity and the Hankel–Majorana lines).

Results:
* `isLorentz_neg` — `O(1,3)` is closed under negation (`-λ` is Lorentz);
* `isLorentz_mul_eta_transpose` — the "dual" metric relation `λ η λᵀ = η`;
* `lorentz_inv_eq` — the explicit inverse `λ⁻¹ = η λᵀ η`;
* `lorentz_time_col` / `lorentz_time_row` — the time–column / time–row identities
  `(λ⁰₀)² = 1 + Σᵢ(λⁱ₀)² = 1 + Σᵢ(λ⁰ᵢ)²`;
* `lorentz_time_sq_ge_one` (`(λ⁰₀)² ≥ 1`) and `lorentz_time_ne_zero` (`λ⁰₀ ≠ 0`);
* `lorentz_inv_time` — `(λ⁻¹)⁰₀ = λ⁰₀`;
* `product_time_component` — the `(0,0)` entry of a matrix product;
* `orthochronous_mul` — **the crux**: the product of two orthochronous Lorentz
  matrices is orthochronous (`a⁰₀ > 0`, `b⁰₀ > 0 ⇒ (ab)⁰₀ > 0`), proved by the
  reverse Cauchy–Schwarz inequality on the time components;
* `IsProperOrthochronous` — the predicate defining `SO⁺(1,3)`;
* `isPO_one`, `isPO_mul`, `isPO_inv` — `SO⁺(1,3)` is a subgroup;
* `isPO_conj` — **headline**: `SO⁺(1,3)` is a **normal** subgroup of `O(1,3)`
  (`g ∈ O(1,3)`, `s ∈ SO⁺(1,3) ⇒ g s g⁻¹ ∈ SO⁺(1,3)`).
-/

namespace BookProof.LorentzOrthochronous

open Matrix
open BookProof.LorentzGroup

/-- `O(1,3)` is closed under negation: if `λ` is Lorentz then so is `-λ`. -/
theorem isLorentz_neg {l : Matrix (Fin 4) (Fin 4) ℝ} (h : IsLorentz l) :
    IsLorentz (-l) := by
  unfold IsLorentz at *
  simp only [transpose_neg, neg_mul, mul_neg, neg_neg]
  exact h

/-- The explicit inverse of a Lorentz matrix: `λ⁻¹ = η λᵀ η`. -/
theorem lorentz_inv_eq {l : Matrix (Fin 4) (Fin 4) ℝ} (h : IsLorentz l) :
    l⁻¹ = eta * lᵀ * eta := by
  apply Matrix.inv_eq_left_inv
  have : (eta * lᵀ * eta) * l = eta * (lᵀ * eta * l) := by simp [Matrix.mul_assoc]
  rw [this, h, eta_mul_self]

/-- From `λᵀ η λ = η` and `η² = 1` we also get the dual relation `λ η λᵀ = η`. -/
theorem isLorentz_mul_eta_transpose {l : Matrix (Fin 4) (Fin 4) ℝ} (h : IsLorentz l) :
    l * eta * lᵀ = eta := by
  have hinv : l⁻¹ = eta * lᵀ * eta := lorentz_inv_eq h
  have hunit : IsUnit l.det := isUnit_iff_ne_zero.mpr (lorentz_det_ne_zero h)
  have hmul : l * l⁻¹ = 1 := Matrix.mul_nonsing_inv l hunit
  rw [hinv] at hmul
  have : (l * eta * lᵀ) * eta = 1 := by rw [← hmul]; simp [Matrix.mul_assoc]
  have h2 := congr_arg (· * eta) this
  simp only [Matrix.one_mul, Matrix.mul_assoc, eta_mul_self, Matrix.mul_one] at h2
  simpa [Matrix.mul_assoc] using h2

/-- Time–column identity: `(λ⁰₀)² = 1 + (λ¹₀)² + (λ²₀)² + (λ³₀)²`
(the first column is a unit time-like vector). -/
theorem lorentz_time_col {l : Matrix (Fin 4) (Fin 4) ℝ} (h : IsLorentz l) :
    (l 0 0) ^ 2 = 1 + (l 1 0) ^ 2 + (l 2 0) ^ 2 + (l 3 0) ^ 2 := by
  have h00 := congr_fun (congr_fun h 0) 0
  simp [mul_apply, Fin.sum_univ_four, eta] at h00
  ring_nf at h00 ⊢
  linarith [h00]

/-- Time–row identity: `(λ⁰₀)² = 1 + (λ⁰₁)² + (λ⁰₂)² + (λ⁰₃)²`
(the first row is a unit time-like vector). -/
theorem lorentz_time_row {l : Matrix (Fin 4) (Fin 4) ℝ} (h : IsLorentz l) :
    (l 0 0) ^ 2 = 1 + (l 0 1) ^ 2 + (l 0 2) ^ 2 + (l 0 3) ^ 2 := by
  have hd := isLorentz_mul_eta_transpose h
  have h00 := congr_fun (congr_fun hd 0) 0
  simp [mul_apply, Fin.sum_univ_four, eta] at h00
  ring_nf at h00 ⊢
  linarith [h00]

/-- `(λ⁰₀)² ≥ 1` for every Lorentz matrix. -/
theorem lorentz_time_sq_ge_one {l : Matrix (Fin 4) (Fin 4) ℝ} (h : IsLorentz l) :
    1 ≤ (l 0 0) ^ 2 := by
  have := lorentz_time_col h
  nlinarith [sq_nonneg (l 1 0), sq_nonneg (l 2 0), sq_nonneg (l 3 0)]

/-- `λ⁰₀ ≠ 0` for every Lorentz matrix. -/
theorem lorentz_time_ne_zero {l : Matrix (Fin 4) (Fin 4) ℝ} (h : IsLorentz l) :
    l 0 0 ≠ 0 := by
  have := lorentz_time_sq_ge_one h
  intro hc; rw [hc] at this; norm_num at this

/-- The `(0,0)` component of the inverse equals that of the matrix: `(λ⁻¹)⁰₀ = λ⁰₀`. -/
theorem lorentz_inv_time {l : Matrix (Fin 4) (Fin 4) ℝ} (h : IsLorentz l) :
    l⁻¹ 0 0 = l 0 0 := by
  rw [lorentz_inv_eq h]
  simp [mul_apply, Fin.sum_univ_four, eta, vecMul, dotProduct]

/-- The `(0,0)` entry of a product of `4×4` matrices. -/
theorem product_time_component (a b : Matrix (Fin 4) (Fin 4) ℝ) :
    (a * b) 0 0 = a 0 0 * b 0 0 + a 0 1 * b 1 0 + a 0 2 * b 2 0 + a 0 3 * b 3 0 := by
  simp [mul_apply, Fin.sum_univ_four]

/-- **Crux (orthochronicity is preserved by multiplication).** If `a, b ∈ O(1,3)`
have positive time components then so does their product.  This is the reverse
Cauchy–Schwarz inequality on the time components. -/
theorem orthochronous_mul {a b : Matrix (Fin 4) (Fin 4) ℝ}
    (ha : IsLorentz a) (hb : IsLorentz b) (h0a : 0 < a 0 0) (h0b : 0 < b 0 0) :
    0 < (a * b) 0 0 := by
  rw [product_time_component]
  have hra := lorentz_time_row ha
  have hcb := lorentz_time_col hb
  nlinarith [sq_nonneg (a 0 1 * b 1 0 + a 0 2 * b 2 0 + a 0 3 * b 3 0),
    sq_nonneg (a 0 1 * b 2 0 - a 0 2 * b 1 0), sq_nonneg (a 0 1 * b 3 0 - a 0 3 * b 1 0),
    sq_nonneg (a 0 2 * b 3 0 - a 0 3 * b 2 0), mul_pos h0a h0b,
    mul_pos (mul_pos h0a h0b) (mul_pos h0a h0b)]

/-- The proper orthochronous Lorentz group `SO⁺(1,3) = {λ ∈ O(1,3) : det λ = 1, λ⁰₀ > 0}`. -/
def IsProperOrthochronous (l : Matrix (Fin 4) (Fin 4) ℝ) : Prop :=
  IsLorentz l ∧ l.det = 1 ∧ 0 < l 0 0

/-- The identity is proper orthochronous. -/
theorem isPO_one : IsProperOrthochronous 1 :=
  ⟨isLorentz_one, by simp, by simp⟩

/-- `SO⁺(1,3)` is closed under multiplication. -/
theorem isPO_mul {a b : Matrix (Fin 4) (Fin 4) ℝ}
    (ha : IsProperOrthochronous a) (hb : IsProperOrthochronous b) :
    IsProperOrthochronous (a * b) := by
  obtain ⟨haL, had, ha0⟩ := ha
  obtain ⟨hbL, hbd, hb0⟩ := hb
  exact ⟨isLorentz_mul haL hbL, by rw [Matrix.det_mul, had, hbd]; ring,
    orthochronous_mul haL hbL ha0 hb0⟩

/-- `SO⁺(1,3)` is closed under inverse: it is a subgroup. -/
theorem isPO_inv {l : Matrix (Fin 4) (Fin 4) ℝ} (h : IsProperOrthochronous l) :
    IsProperOrthochronous l⁻¹ := by
  obtain ⟨hL, hd, h0⟩ := h
  refine ⟨isLorentz_inv hL, ?_, ?_⟩
  · rw [Matrix.det_nonsing_inv, hd]; simp
  · rw [lorentz_inv_time hL]; exact h0

/-- **Headline: `SO⁺(1,3)` is a normal subgroup of `O(1,3)`.** For any Lorentz `g`
and any proper orthochronous `s`, the conjugate `g s g⁻¹` is proper orthochronous.

The determinant is `det g · 1 · (det g)⁻¹ = 1`; orthochronicity is preserved by a
case split on the sign of `g⁰₀` (which is nonzero), using that `-g` is also Lorentz
with `(-g)⁰₀ = -g⁰₀` and `(-g)⁻¹ = -g⁻¹`, so the two sign flips cancel. -/
theorem isPO_conj {g s : Matrix (Fin 4) (Fin 4) ℝ}
    (hg : IsLorentz g) (hs : IsProperOrthochronous s) :
    IsProperOrthochronous (g * s * g⁻¹) := by
  obtain ⟨hsL, hsd, hs0⟩ := hs
  have hgunit : IsUnit g.det := isUnit_iff_ne_zero.mpr (lorentz_det_ne_zero hg)
  have hginvL : IsLorentz g⁻¹ := isLorentz_inv hg
  have hL : IsLorentz (g * s * g⁻¹) := isLorentz_mul (isLorentz_mul hg hsL) hginvL
  refine ⟨hL, ?_, ?_⟩
  · rw [Matrix.det_mul, Matrix.det_mul, hsd, Matrix.det_nonsing_inv, mul_one,
      Ring.mul_inverse_cancel _ hgunit]
  · have hg0 := lorentz_time_ne_zero hg
    rcases lt_or_gt_of_ne hg0 with hneg | hpos
    · -- `g⁰₀ < 0`: conjugate by `-g` instead (the two sign flips cancel)
      have hng : IsLorentz (-g) := isLorentz_neg hg
      have hng0 : 0 < (-g) 0 0 := by rw [neg_apply]; linarith
      have hnginvL : IsLorentz (-g)⁻¹ := isLorentz_inv hng
      have hnginv0 : 0 < (-g)⁻¹ 0 0 := by rw [lorentz_inv_time hng, neg_apply]; linarith
      have h1 : 0 < ((-g) * s) 0 0 := orthochronous_mul hng hsL hng0 hs0
      have key : 0 < ((-g) * s * (-g)⁻¹) 0 0 :=
        orthochronous_mul (isLorentz_mul hng hsL) hnginvL h1 hnginv0
      have hneginv : (-g)⁻¹ = -(g⁻¹) := by
        rw [lorentz_inv_eq hng, lorentz_inv_eq hg, transpose_neg]
        simp 
      have heq : (-g) * s * (-g)⁻¹ = g * s * g⁻¹ := by
        rw [hneginv]; simp 
      rw [heq] at key; exact key
    · -- `g⁰₀ > 0`: both `g` and `g⁻¹` are orthochronous
      have hginv0 : 0 < g⁻¹ 0 0 := by rw [lorentz_inv_time hg]; exact hpos
      have h1 : 0 < (g * s) 0 0 := orthochronous_mul hg hsL hpos hs0
      exact orthochronous_mul (isLorentz_mul hg hsL) hginvL h1 hginv0

end BookProof.LorentzOrthochronous

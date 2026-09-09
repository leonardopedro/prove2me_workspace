import Mathlib

/-!
# Chapter "Real representations, CPT theorem …", §"On the Lorentz, SL(2,C) and Pin(3,1) groups":
the Lorentz group `O(1,3)` and its discrete subgroup `Δ = {1, η, -η, -1}`

This file formalizes the self-contained group-theoretic content of `book.tex`
**Note 43** (`book.tex` line ~5340, chapter *"Real representations, CPT theorem
and the relativistic position operator"*, §*"On the Lorentz, SL(2,C) and
Pin(3,1) groups"*):

> The Lorentz group, `O(1,3) ≡ {λ ∈ ℝ^{4×4} : λᵀ η λ = η}`, is the set of real
> matrices that leave the metric `η = diag(1,-1,-1,-1)` invariant. […] The
> discrete Lorentz subgroup of parity and time-reversal is `Δ ≡ {1, η, -η, -1}`.

Modelling the Minkowski metric `η = diag(1,-1,-1,-1)` as an explicit real
`4×4` matrix (this uses **only** the metric, no Majorana / gamma matrices).

Results:
* `eta_transpose`, `eta_mul_self` (`η² = 1`), `eta_det` (`det η = -1`) — the basic
  properties of the metric;
* `IsLorentz` — the defining predicate of `O(1,3)`;
* `isLorentz_one`, `isLorentz_mul`, `isLorentz_inv` — `O(1,3)` is closed under the
  identity, matrix product, and matrix inverse: it is a **group**;
* `lorentz_det_sq_one` (`(det λ)² = 1`) and `lorentz_det_ne_zero` — every Lorentz
  matrix is invertible with determinant `±1`;
* `isLorentz_eta`, `isLorentz_neg_eta`, `isLorentz_neg_one` — the three nontrivial
  discrete generators are Lorentz;
* `Delta` — the discrete subgroup `Δ = {1, η, -η, -1}`;
* `delta_subset_lorentz` — `Δ ⊆ O(1,3)`;
* `delta_mul_closed` — `Δ` is closed under multiplication;
* `delta_involutive` — every element of `Δ` squares to `1`
  (so `Δ` is abelian and `≅ ℤ₂ × ℤ₂`, the Klein four-group);
* `delta_card_four` — the four listed elements are distinct, so `|Δ| = 4`.
-/

namespace BookProof.LorentzGroup

open Matrix

/-- The Minkowski metric `η = diag(1, -1, -1, -1)` as an explicit real `4×4`
matrix. -/
def eta : Matrix (Fin 4) (Fin 4) ℝ :=
  !![1, 0, 0, 0; 0, -1, 0, 0; 0, 0, -1, 0; 0, 0, 0, -1]

/-
The metric is symmetric: `ηᵀ = η`.
-/
theorem eta_transpose : etaᵀ = eta := by
  ext i j; fin_cases i <;> fin_cases j <;> rfl;

/-
The metric is an involution: `η² = 1`.
-/
theorem eta_mul_self : eta * eta = 1 := by
  ext i j; fin_cases i <;> fin_cases j <;> simp [ eta, Matrix.mul_apply ] ;
  all_goals norm_num [ Fin.sum_univ_succ, Fin.sum_univ_zero ] ;

/-
The determinant of the metric is `-1`.
-/
theorem eta_det : eta.det = -1 := by
  norm_num [ Matrix.det_succ_row_zero, eta ];
  simp [ Fin.sum_univ_succ ]

/-- The Lorentz group `O(1,3)`: real `4×4` matrices preserving the Minkowski
metric `η`, i.e. `λᵀ η λ = η`. -/
def IsLorentz (l : Matrix (Fin 4) (Fin 4) ℝ) : Prop := lᵀ * eta * l = eta

/-
The identity matrix is a Lorentz transformation.
-/
theorem isLorentz_one : IsLorentz 1 := by
  -- By definition of IsLorentz, we need to show that 1^T * eta * 1 = eta.
  simp [IsLorentz]

/-
The product of two Lorentz transformations is a Lorentz transformation.
-/
theorem isLorentz_mul {a b : Matrix (Fin 4) (Fin 4) ℝ}
    (ha : IsLorentz a) (hb : IsLorentz b) : IsLorentz (a * b) := by
      unfold IsLorentz at *; simp_all [ Matrix.mul_assoc ] ;
      simp_all [ ← Matrix.mul_assoc ]

/-
The determinant of a Lorentz transformation squares to `1`.
-/
theorem lorentz_det_sq_one {l : Matrix (Fin 4) (Fin 4) ℝ} (h : IsLorentz l) :
    l.det ^ 2 = 1 := by
      unfold IsLorentz at h;
      apply_fun Matrix.det at h; norm_num [ eta_det ] at h; linarith;

/-
A Lorentz transformation has nonzero determinant, hence is invertible.
-/
theorem lorentz_det_ne_zero {l : Matrix (Fin 4) (Fin 4) ℝ} (h : IsLorentz l) :
    l.det ≠ 0 := by
      have := lorentz_det_sq_one h; aesop;

/-
The inverse of a Lorentz transformation is a Lorentz transformation:
so `O(1,3)` is a group.
-/
theorem isLorentz_inv {l : Matrix (Fin 4) (Fin 4) ℝ} (h : IsLorentz l) :
    IsLorentz l⁻¹ := by
      unfold IsLorentz at *;
      rw [ Matrix.transpose_nonsing_inv ];
      have h_inv : IsUnit l.det := by
        exact isUnit_iff_ne_zero.mpr ( lorentz_det_ne_zero h );
      replace h := congr_arg ( fun x => x * l⁻¹ ) h
      simp_all [ Matrix.mul_assoc, isUnit_iff_ne_zero ]
      simp [ ← h, h_inv, isUnit_iff_ne_zero ]

/-
The metric `η` (parity × time-reversal) is a Lorentz transformation.
-/
theorem isLorentz_eta : IsLorentz eta := by
  simp only [IsLorentz, eta_transpose];
  rw [ eta_mul_self, Matrix.one_mul ]

/-
`-η` is a Lorentz transformation.
-/
theorem isLorentz_neg_eta : IsLorentz (-eta) := by
  ext i j; fin_cases i <;> fin_cases j <;> norm_num [ Matrix.mul_apply, Fin.sum_univ_succ, eta ] ;

/-
`-1` (full inversion `PT`) is a Lorentz transformation.
-/
theorem isLorentz_neg_one : IsLorentz (-1 : Matrix (Fin 4) (Fin 4) ℝ) := by
  -- By definition of IsLorentz, we need to show that (-1)ᵀ * eta * (-1) = eta.
  simp [IsLorentz]

/-- The discrete Lorentz subgroup `Δ = {1, η, -η, -1}` of parity and
time-reversal. -/
def Delta : Set (Matrix (Fin 4) (Fin 4) ℝ) := {1, eta, -eta, -1}

/-
Every element of `Δ` is a Lorentz transformation: `Δ ⊆ O(1,3)`.
-/
theorem delta_subset_lorentz : ∀ x ∈ Delta, IsLorentz x := by
  intro x hx; unfold Delta at hx
  rcases hx with ( rfl | rfl | rfl | rfl ) <;>
    [ exact isLorentz_one; exact isLorentz_eta; exact isLorentz_neg_eta;
      exact isLorentz_neg_one ]

/-
`Δ` is closed under matrix multiplication.
-/
theorem delta_mul_closed : ∀ x ∈ Delta, ∀ y ∈ Delta, x * y ∈ Delta := by
  -- every element of `Δ` is one of `1, η, -η, -1`; multiply out the 16 cases
  simp only [Delta, Set.mem_insert_iff, Set.mem_singleton_iff]
  norm_num [eta_mul_self]

/-
Every element of `Δ` squares to the identity: `Δ` is abelian and isomorphic
to the Klein four-group `ℤ₂ × ℤ₂`.
-/
theorem delta_involutive : ∀ x ∈ Delta, x * x = 1 := by
  rintro x ( rfl | rfl | rfl | rfl ) <;> norm_num [ eta_mul_self ]

/-
The four listed elements `1, η, -η, -1` are pairwise distinct, so `|Δ| = 4`.
-/
theorem delta_card_four :
    ({1, eta, -eta, -1} : Finset (Matrix (Fin 4) (Fin 4) ℝ)).card = 4 := by
  rw [Finset.card_insert_of_notMem, Finset.card_insert_of_notMem,
    Finset.card_insert_of_notMem, Finset.card_singleton] <;>
    norm_num [Matrix.one_fin_two, eta]
  · exact ne_of_apply_ne (fun m => m 1 1) (by norm_num)
  · intro h; have := congr_fun (congr_fun h 0) 0; norm_num at this
  · refine ⟨?_, ?_, ?_⟩ <;> intro h <;> have := congr_fun (congr_fun h 0) 0 <;>
      norm_num at this
    exact absurd (congr_fun (congr_fun h 1) 1) (by norm_num)

end BookProof.LorentzGroup

import Mathlib
import BookProof.ChapterA3
import BookProof.ChapterA3h

/-!
# Chapter A, §A.3 — Lemma 48: the bridge `Λ(Σ ∘ T ∘ Σ⁻¹) = Υ(T)`

Source: `book.tex` line 5458 (**Lemma 48**), work-package **N4** of
`FORMALIZATION_ROADMAP.md`.

This module supplies the **`Σ` / bridge half of Lemma 48**, the piece connecting
the two concrete double covers of the Lorentz group built earlier:

* the **Pauli / `SL(2,ℂ)`** cover `Υ : SL(2,ℂ) → O(1,3)` of
  `ChapterA3h.lean` (Note 47), `Υ^μ_ν(T) σ^ν = T† σ^μ T`;
* the **Majorana / Pinor** cover `Λ : Pin(3,1) → O(1,3)` of `ChapterA3c.lean`
  (Prop 46), `Λ(S)^μ_ν iγ^ν = S⁻¹ iγ^μ S`.

The book's explicit real-linear isomorphism `Σ : Pauli → Pinor` (book eq. 5468)
matches the `±`-eigenspaces of `γ⁰γ³` (on `Pinor = ℂ⁴`, real form) with those of
`σ³` (on `Pauli = ℂ²`, real form). Concretely, in the Majorana basis of
`ChapterA3.lean`, taking `M₊ = e₀ + e₃`, `M₋ = e₀ - e₃`, the isomorphism `Σ` is
the integer `4×4` matrix

`Σ = !![1,0,0,-1; 0,-1,-1,0; 0,-1,1,0; 1,0,0,1]`,

which satisfies `Σ Σᵀ = 2` (so `Σ⁻¹ = ½ Σᵀ`).

For `T ∈ SL(2,ℂ)` we realise `Σ ∘ T ∘ Σ⁻¹ ∈ Spin⁺(3,1)` concretely as the real
`4×4` matrix `Spinor T := Σ · Tᵣ · (½ Σᵀ)`, where `Tᵣ = Treal T` is the real
`4×4` form of the `ℂ`-linear action of `T` on `ℂ²` in the ordered real basis
`(P₊, iP₊, P₋, iP₋)`.  Its inverse (when `det T = 1`) is `SpinorInv T`, built the
same way from the adjugate `T⁻¹ = !![d,-b;-c,a]`.

The **headline** is the bridge identity (proved as a pure polynomial identity in
the entries of `T`, no `det T = 1` needed):

`SpinorInv T · iγ^μ · Spinor T = ∑_ν Υ(T)^ν_μ · iγ^ν`,

i.e. conjugation by `Spinor T` acts on the Majorana basis exactly by the (real)
matrix `Υ(T)ᵀ` — the Pinor cover `Λ` of `Σ T Σ⁻¹` equals the Pauli cover `Υ` of
`T` (transposed by the `Λ`/`Υ` index conventions).  Combined with
`Spinor T · SpinorInv T = 1` (which *does* use `det T = 1`), we get the same
statement with the genuine inverse `(Spinor T)⁻¹`.

Everything here is `sorry`-free and `axiom`-free (only `propext`,
`Classical.choice`, `Quot.sound`).
-/

open Matrix
open scoped ComplexConjugate

namespace BookProof.ChapterA3

/-! ## The isomorphism `Σ` -/

/-- The integer matrix of the Pauli→Pinor isomorphism `Σ` (book eq. 5468) in the
Majorana basis of `ChapterA3.lean`, with `M₊ = e₀+e₃`, `M₋ = e₀-e₃`. -/
def SigmaZ : Matrix (Fin 4) (Fin 4) ℤ :=
  !![1,0,0,-1; 0,-1,-1,0; 0,-1,1,0; 1,0,0,1]

/-- `Σ Σᵀ = 2·1`, i.e. the columns `M₊, -iγ⁵M₊, M₋, -iγ⁵M₋` are orthogonal of
squared norm `2`. -/
theorem sigmaZ_mul_transpose :
    SigmaZ * SigmaZᵀ = (2 : ℤ) • (1 : Matrix (Fin 4) (Fin 4) ℤ) := by
  decide

/-- The complex form of `Σ`. -/
noncomputable def SigmaC : Matrix (Fin 4) (Fin 4) ℂ :=
  (Int.castRingHom ℂ).mapMatrix SigmaZ

theorem sigmaC_mul_transpose :
    SigmaC * SigmaCᵀ = (2 : ℂ) • (1 : Matrix (Fin 4) (Fin 4) ℂ) := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [SigmaC, SigmaZ, Matrix.mul_apply, Fin.sum_univ_four, Matrix.transpose_apply,
      RingHom.mapMatrix_apply, Matrix.smul_apply] <;> norm_num

/-! ## The real form of `T` and the spinor matrices -/

/-- The real `4×4` form of the `ℂ`-linear action of a `2×2` complex matrix `T` on
`ℂ²`, in the ordered real basis `(P₊, iP₊, P₋, iP₋)` of `Pauli = ℂ²`. -/
noncomputable def Treal (T : Matrix (Fin 2) (Fin 2) ℂ) :
    Matrix (Fin 4) (Fin 4) ℂ :=
  !![ ((T 0 0).re : ℂ), -((T 0 0).im : ℂ), ((T 0 1).re : ℂ), -((T 0 1).im : ℂ);
      ((T 0 0).im : ℂ),  ((T 0 0).re : ℂ), ((T 0 1).im : ℂ),  ((T 0 1).re : ℂ);
      ((T 1 0).re : ℂ), -((T 1 0).im : ℂ), ((T 1 1).re : ℂ), -((T 1 1).im : ℂ);
      ((T 1 0).im : ℂ),  ((T 1 0).re : ℂ), ((T 1 1).im : ℂ),  ((T 1 1).re : ℂ) ]

/-- The adjugate `!![d,-b;-c,a]` of `T = !![a,b;c,d]` (equal to `T⁻¹` when
`det T = 1`). -/
noncomputable def adj2 (T : Matrix (Fin 2) (Fin 2) ℂ) : Matrix (Fin 2) (Fin 2) ℂ :=
  !![ T 1 1, -(T 0 1); -(T 1 0), T 0 0 ]

/-- The concrete realisation of `Σ ∘ T ∘ Σ⁻¹ ∈ Spin⁺(3,1)` as a real `4×4`
matrix, `Spinor T = Σ · Treal T · (½ Σᵀ)`. -/
noncomputable def Spinor (T : Matrix (Fin 2) (Fin 2) ℂ) : Matrix (Fin 4) (Fin 4) ℂ :=
  SigmaC * Treal T * ((2⁻¹ : ℂ) • SigmaCᵀ)

/-- The candidate inverse of `Spinor T`, built from the adjugate of `T`. -/
noncomputable def SpinorInv (T : Matrix (Fin 2) (Fin 2) ℂ) : Matrix (Fin 4) (Fin 4) ℂ :=
  SigmaC * Treal (adj2 T) * ((2⁻¹ : ℂ) • SigmaCᵀ)

/-
The real form is multiplicative: `Treal (A B) = Treal A · Treal B` (the real
form of a `ℂ`-linear map is a ring homomorphism `Mat₂(ℂ) → Mat₄(ℝ)`).
-/
theorem Treal_mul (A B : Matrix (Fin 2) (Fin 2) ℂ) :
    Treal (A * B) = Treal A * Treal B := by
  unfold Treal;
  ext i j;    fin_cases i <;> fin_cases j <;> simp [ Matrix.mul_apply, Fin.sum_univ_succ ] <;> ring;

/-- `Treal 1 = 1`. -/
theorem Treal_one : Treal (1 : Matrix (Fin 2) (Fin 2) ℂ) = 1 := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [Treal]

/-- `Treal` of a scalar matrix `c • 1` is `(Re c)·1 + (Im c)·J` — in particular
`Treal ((1:ℂ) • 1) = 1`.  Packaged for the determinant computation:
`Treal (T · adj2 T) = Treal 1` when `det T = 1`. -/
theorem T_mul_adj2 (T : Matrix (Fin 2) (Fin 2) ℂ)
    (hdet : T 0 0 * T 1 1 - T 0 1 * T 1 0 = 1) :
    T * adj2 T = 1 := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp only [adj2, Fin.isValue, Fin.zero_eta, mul_apply, of_apply, cons_val', cons_val_zero,
        cons_val_fin_one, Fin.sum_univ_two, cons_val_one, mul_neg, one_apply_eq, Fin.mk_one, ne_eq,
            zero_ne_one, not_false_eq_true, one_apply_ne, one_ne_zero] <;>
    first | linear_combination hdet | ring

/-- `adj2 T · T = 1` when `det T = 1`. -/
theorem adj2_mul_T (T : Matrix (Fin 2) (Fin 2) ℂ)
    (hdet : T 0 0 * T 1 1 - T 0 1 * T 1 0 = 1) :
    adj2 T * T = 1 := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp only [adj2, Fin.isValue, Fin.zero_eta, mul_apply, of_apply, cons_val', cons_val_fin_one,
        cons_val_zero, Fin.sum_univ_two, cons_val_one, neg_mul, one_apply_eq, Fin.mk_one, ne_eq,
            zero_ne_one, not_false_eq_true, one_apply_ne, one_ne_zero] <;>
    first | linear_combination hdet | ring

/-- `Σᵀ Σ = 2·1`. -/
theorem sigmaC_transpose_mul :
    SigmaCᵀ * SigmaC = (2 : ℂ) • (1 : Matrix (Fin 4) (Fin 4) ℂ) := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [SigmaC, SigmaZ, Matrix.mul_apply, Fin.sum_univ_four, Matrix.transpose_apply,
      RingHom.mapMatrix_apply, Matrix.smul_apply] <;> norm_num

/-! ## The bridge identity -/

/-
**The bridge identity (pure algebra).**  Conjugation of the Majorana basis by
`Spinor T` is given by the Pauli-cover matrix `Υ(T)` (transposed by the index
conventions):
`SpinorInv T · iγ^μ · Spinor T = ∑_ν Υ(T)^ν_μ · iγ^ν`.
This holds as a polynomial identity in the entries of `T`; `det T = 1` is *not*
needed.
-/
set_option maxHeartbeats 2000000 in
-- the proof below is a large finite computation; the default heartbeat budget
-- is not enough to elaborate it
theorem spinorInv_conj_mgamma (T : Matrix (Fin 2) (Fin 2) ℂ) (μ : Fin 4) :
    SpinorInv T * mgamma μ * Spinor T = ∑ ν, UpsilonC T ν μ • mgamma ν := by
  unfold SpinorInv Spinor UpsilonC mgamma;
  simp only [SigmaC, SigmaZ, Int.reduceNeg, RingHom.mapMatrix_apply, Int.coe_castRingHom, Treal,
    adj2, Fin.isValue, of_apply, cons_val', cons_val_zero, empty_val', cons_val_fin_one,
    cons_val_one, Complex.neg_re, Complex.ofReal_neg, Complex.neg_im, neg_neg,
    Algebra.mul_smul_comm, mgammaZ, Algebra.smul_mul_assoc, pauliCoeff, trace, diag, pauliσ,
    mul_apply, conjTranspose_apply, RCLike.star_def, Fin.sum_univ_two, Fin.sum_univ_four,
    one_mul, zero_mul, add_zero, zero_add, neg_mul, neg_add_rev];
  rw [ ← Matrix.ext_iff ] at *;
  fin_cases μ <;> simp [ Fin.sum_univ_succ, Matrix.mul_apply ] at *;
  · simp [ Fin.forall_fin_succ, Complex.ext_iff ] at *;
    grind;
  · norm_num [ Fin.forall_fin_succ, Complex.ext_iff ] at *;
    grind;
  · simp [ Fin.forall_fin_succ, Complex.ext_iff ] at *;
    grind;
  · simp [ Fin.forall_fin_succ, Complex.ext_iff ] at *;
    grind

/-- `Spinor T · SpinorInv T = 1` for `T ∈ SL(2,ℂ)` (`det T = 1`). -/
theorem spinor_mul_spinorInv (T : Matrix (Fin 2) (Fin 2) ℂ)
    (hdet : T 0 0 * T 1 1 - T 0 1 * T 1 0 = 1) :
    Spinor T * SpinorInv T = 1 := by
  have hmid : ((2⁻¹ : ℂ) • SigmaCᵀ) * SigmaC = 1 := by
    rw [Matrix.smul_mul, sigmaC_transpose_mul, smul_smul]; norm_num
  have hend : SigmaC * ((2⁻¹ : ℂ) • SigmaCᵀ) = 1 := by
    rw [Matrix.mul_smul, sigmaC_mul_transpose, smul_smul]; norm_num
  unfold Spinor SpinorInv
  calc SigmaC * Treal T * ((2⁻¹ : ℂ) • SigmaCᵀ)
          * (SigmaC * Treal (adj2 T) * ((2⁻¹ : ℂ) • SigmaCᵀ))
      = SigmaC * Treal T * (((2⁻¹ : ℂ) • SigmaCᵀ) * SigmaC)
          * Treal (adj2 T) * ((2⁻¹ : ℂ) • SigmaCᵀ) := by
        simp only [Matrix.mul_assoc]
    _ = SigmaC * Treal T * Treal (adj2 T) * ((2⁻¹ : ℂ) • SigmaCᵀ) := by
        rw [hmid, Matrix.mul_one]
    _ = SigmaC * Treal (T * adj2 T) * ((2⁻¹ : ℂ) • SigmaCᵀ) := by
        rw [Treal_mul]; simp only [Matrix.mul_assoc]
    _ = SigmaC * Treal 1 * ((2⁻¹ : ℂ) • SigmaCᵀ) := by rw [T_mul_adj2 T hdet]
    _ = SigmaC * ((2⁻¹ : ℂ) • SigmaCᵀ) := by rw [Treal_one, Matrix.mul_one]
    _ = 1 := hend

/-- `SpinorInv T · Spinor T = 1` for `T ∈ SL(2,ℂ)`. -/
theorem spinorInv_mul_spinor (T : Matrix (Fin 2) (Fin 2) ℂ)
    (hdet : T 0 0 * T 1 1 - T 0 1 * T 1 0 = 1) :
    SpinorInv T * Spinor T = 1 := by
  have hmid : ((2⁻¹ : ℂ) • SigmaCᵀ) * SigmaC = 1 := by
    rw [Matrix.smul_mul, sigmaC_transpose_mul, smul_smul]; norm_num
  have hend : SigmaC * ((2⁻¹ : ℂ) • SigmaCᵀ) = 1 := by
    rw [Matrix.mul_smul, sigmaC_mul_transpose, smul_smul]; norm_num
  unfold Spinor SpinorInv
  calc SigmaC * Treal (adj2 T) * ((2⁻¹ : ℂ) • SigmaCᵀ)
          * (SigmaC * Treal T * ((2⁻¹ : ℂ) • SigmaCᵀ))
      = SigmaC * Treal (adj2 T) * (((2⁻¹ : ℂ) • SigmaCᵀ) * SigmaC)
          * Treal T * ((2⁻¹ : ℂ) • SigmaCᵀ) := by
        simp only [Matrix.mul_assoc]
    _ = SigmaC * Treal (adj2 T) * Treal T * ((2⁻¹ : ℂ) • SigmaCᵀ) := by
        rw [hmid, Matrix.mul_one]
    _ = SigmaC * Treal (adj2 T * T) * ((2⁻¹ : ℂ) • SigmaCᵀ) := by
        rw [Treal_mul]; simp only [Matrix.mul_assoc]
    _ = SigmaC * Treal 1 * ((2⁻¹ : ℂ) • SigmaCᵀ) := by rw [adj2_mul_T T hdet]
    _ = SigmaC * ((2⁻¹ : ℂ) • SigmaCᵀ) := by rw [Treal_one, Matrix.mul_one]
    _ = 1 := hend

/-- For `T ∈ SL(2,ℂ)`, `SpinorInv T` is the genuine matrix inverse of
`Spinor T`. -/
theorem spinor_inv_eq (T : Matrix (Fin 2) (Fin 2) ℂ)
    (hdet : T 0 0 * T 1 1 - T 0 1 * T 1 0 = 1) :
    (Spinor T)⁻¹ = SpinorInv T :=
  Matrix.inv_eq_right_inv (spinor_mul_spinorInv T hdet)

/-- **Lemma 48 (bridge).**  For `T ∈ SL(2,ℂ)`, conjugation of the Majorana basis
`{iγ^μ}` by the spin-group element `Spinor T = Σ T Σ⁻¹` is realised by the
Pauli-cover matrix `Υ(T)`:
`(Spinor T)⁻¹ · iγ^μ · Spinor T = ∑_ν Υ(T)^ν_μ · iγ^ν`.
This is the identity `Λ(Σ T Σ⁻¹) = Υ(T)` of Lemma 48 in the concrete model. -/
theorem lemma48_bridge (T : Matrix (Fin 2) (Fin 2) ℂ)
    (hdet : T 0 0 * T 1 1 - T 0 1 * T 1 0 = 1) (μ : Fin 4) :
    (Spinor T)⁻¹ * mgamma μ * Spinor T = ∑ ν, UpsilonC T ν μ • mgamma ν := by
  rw [spinor_inv_eq T hdet]
  exact spinorInv_conj_mgamma T μ

end BookProof.ChapterA3
